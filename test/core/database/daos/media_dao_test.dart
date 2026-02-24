// test/core/database/daos/media_dao_test.dart
//
// Tests para MediaDao — especialmente la lógica de fotos huérfanas
// que agregaste recientemente.
//
// Para correr SOLO este archivo:
//   flutter test test/core/database/daos/media_dao_test.dart
//
// Para correr todos los tests:
//   flutter test

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

// Ajusta el import al nombre de tu paquete (ver pubspec.yaml → name:)
import 'package:fieldsync_pro/core/database/app_database.dart';

// ─── Helper: crea una BD en memoria (no toca el disco) ───────────────────────

AppDatabase _buildInMemoryDb() {
  // NativeDatabase.memory() es la versión de tests — no necesita path_provider
  return AppDatabase.forTesting(NativeDatabase.memory());
}

// ─── Helper: inserta una inspección mínima ────────────────────────────────────

Future<void> _insertInspection(AppDatabase db, {required String uuid}) async {
  await db.inspectionsDao.insertInspection(
    InspectionsTableCompanion.insert(
      localUuid: uuid,
      assetRemoteId: 'asset-1',
      formId: 'form-1',
      formVersion: 1,
      technicianDeviceId: 'device-1',
      formData: '{}',
    ),
  );
}

// ─── Helper: inserta una foto ─────────────────────────────────────────────────

Future<void> _insertMedia(
    AppDatabase db, {
      required String inspectionUuid,
      String localPath = '/fake/path/photo.jpg',
      bool isUploaded = false,
    }) async {
  await db.mediaDao.insertMedia(
    MediaFilesTableCompanion.insert(
      inspectionUuid: inspectionUuid,
      fieldId: 'field-foto',
      localPath: localPath,
      isUploaded: Value(isUploaded),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────

void main() {
  late AppDatabase db;

  // setUp corre ANTES de cada test — siempre empezamos con una BD limpia
  setUp(() {
    db = _buildInMemoryDb();
  });

  // tearDown corre DESPUÉS de cada test — cierra la BD para liberar memoria
  tearDown(() async {
    await db.close();
  });

  // ══════════════════════════════════════════════════════════════════════════
  // Grupo 1 — insertMedia / getByInspectionUuid
  // ══════════════════════════════════════════════════════════════════════════

  group('insertMedia y getByInspectionUuid', () {
    test('inserta una foto y la recupera por UUID de inspección', () async {
      await _insertInspection(db, uuid: 'insp-001');
      await _insertMedia(db, inspectionUuid: 'insp-001');

      final fotos = await db.mediaDao.getByInspectionUuid('insp-001');

      expect(fotos.length, 1);
      expect(fotos.first.inspectionUuid, 'insp-001');
      expect(fotos.first.isUploaded, false);
    });

    test('no devuelve fotos de otra inspección', () async {
      await _insertMedia(db, inspectionUuid: 'insp-A');
      await _insertMedia(db, inspectionUuid: 'insp-B');

      final fotos = await db.mediaDao.getByInspectionUuid('insp-A');

      expect(fotos.length, 1);
      expect(fotos.first.inspectionUuid, 'insp-A');
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  // Grupo 2 — getPendingUploads
  // ══════════════════════════════════════════════════════════════════════════

  group('getPendingUploads', () {
    test('solo devuelve fotos no subidas', () async {
      await _insertMedia(db, inspectionUuid: 'insp-1', isUploaded: false);
      await _insertMedia(db, inspectionUuid: 'insp-1', isUploaded: false);
      await _insertMedia(db, inspectionUuid: 'insp-2', isUploaded: true); // ya subida

      final pending = await db.mediaDao.getPendingUploads();

      expect(pending.length, 2);
      expect(pending.every((f) => f.isUploaded == false), true);
    });

    test('devuelve lista vacía si todas están subidas', () async {
      await _insertMedia(db, inspectionUuid: 'insp-1', isUploaded: true);

      final pending = await db.mediaDao.getPendingUploads();

      expect(pending, isEmpty);
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  // Grupo 3 — markAsUploaded
  // ══════════════════════════════════════════════════════════════════════════

  group('markAsUploaded', () {
    test('marca la foto como subida y guarda la URL remota', () async {
      await _insertMedia(db, inspectionUuid: 'insp-1');
      final fotos = await db.mediaDao.getByInspectionUuid('insp-1');
      final id = fotos.first.id;

      await db.mediaDao.markAsUploaded(id, 'https://cdn.example.com/foto.jpg');

      final updated = await db.mediaDao.getByInspectionUuid('insp-1');
      expect(updated.first.isUploaded, true);
      expect(updated.first.remoteUrl, 'https://cdn.example.com/foto.jpg');
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  // Grupo 4 — deleteOrphanMedia  ← el que más importa testear
  // ══════════════════════════════════════════════════════════════════════════

  group('deleteOrphanMedia', () {
    test('elimina fotos cuya inspección NO existe en la BD', () async {
      // Solo insertamos la foto — sin inspección asociada (= huérfana)
      await _insertMedia(db, inspectionUuid: 'insp-borrada');

      final deleted = await db.mediaDao.deleteOrphanMedia();

      expect(deleted, 1);
      final restantes = await db.mediaDao.getPendingUploads();
      expect(restantes, isEmpty);
    });

    test('NO toca fotos cuya inspección SÍ existe', () async {
      await _insertInspection(db, uuid: 'insp-viva');
      await _insertMedia(db, inspectionUuid: 'insp-viva');

      final deleted = await db.mediaDao.deleteOrphanMedia();

      expect(deleted, 0);
      final restantes = await db.mediaDao.getByInspectionUuid('insp-viva');
      expect(restantes.length, 1);
    });

    test('elimina solo las huérfanas y preserva las válidas', () async {
      await _insertInspection(db, uuid: 'insp-viva');
      await _insertMedia(db, inspectionUuid: 'insp-viva');     // válida
      await _insertMedia(db, inspectionUuid: 'insp-borrada');  // huérfana

      final deleted = await db.mediaDao.deleteOrphanMedia();

      expect(deleted, 1); // solo eliminó 1
      final restantes = await db.mediaDao.getPendingUploads();
      expect(restantes.length, 1);
      expect(restantes.first.inspectionUuid, 'insp-viva');
    });

    test('NO elimina fotos ya subidas aunque la inspección no exista', () async {
      // Las fotos ya subidas no son "pendingUploads", el DAO no las toca
      await _insertMedia(
        db,
        inspectionUuid: 'insp-borrada',
        isUploaded: true,
      );

      final deleted = await db.mediaDao.deleteOrphanMedia();

      expect(deleted, 0);
    });

    test('devuelve 0 si no hay fotos en absoluto', () async {
      final deleted = await db.mediaDao.deleteOrphanMedia();
      expect(deleted, 0);
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  // Grupo 5 — deleteByInspectionUuid
  // ══════════════════════════════════════════════════════════════════════════

  group('deleteByInspectionUuid', () {
    test('elimina todas las fotos de una inspección específica', () async {
      await _insertMedia(db, inspectionUuid: 'insp-X');
      await _insertMedia(db, inspectionUuid: 'insp-X');
      await _insertMedia(db, inspectionUuid: 'insp-Y'); // no debe borrarse

      await db.mediaDao.deleteByInspectionUuid('insp-X');

      final restantes = await db.mediaDao.getPendingUploads();
      expect(restantes.length, 1);
      expect(restantes.first.inspectionUuid, 'insp-Y');
    });
  });
}
