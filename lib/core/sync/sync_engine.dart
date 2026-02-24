import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/daos/outbox_dao.dart';
import '../database/daos/inspections_dao.dart';
import '../database/daos/assets_dao.dart';
import '../database/daos/media_dao.dart';

import '../network/dio_provider.dart';

import 'package:drift/drift.dart';

part 'sync_engine.g.dart';

@Riverpod(keepAlive: true)
SyncEngine syncEngine(SyncEngineRef ref) {
  return SyncEngine(
    outboxDao: ref.watch(outboxDaoProvider),
    inspectionsDao: ref.watch(inspectionsDaoProvider),
    assetsDao: ref.watch(assetsDaoProvider),
    mediaDao: ref.watch(mediaDaoProvider),
    dio: ref.watch(dioProvider),
  );
}

class SyncEngine {
  final OutboxDao outboxDao;
  final InspectionsDao inspectionsDao;
  final AssetsDao assetsDao;
  final MediaDao mediaDao;
  final Dio dio;

  SyncEngine({
    required this.outboxDao,
    required this.inspectionsDao,
    required this.assetsDao,
    required this.mediaDao,
    required this.dio,
  });

  /// Sync completo: sube outbox + baja activos del servidor
  Future<SyncResult> sync() async {
    int synced = 0;
    int failed = 0;

    final items = await outboxDao.getPendingItems();
    print('🟡 Iniciando sync — items en outbox: ${items.length}');

    // ── 1. Subir outbox (inspecciones y activos) ──────────────────────
    for (final item in items) {
      try {
        print('🔄 Procesando: ${item.entityType} - ${item.entityId}');

        await _processItem(item);
        await outboxDao.deleteItem(item.id);
        synced++;
        print('✅ Sincronizado: ${item.entityType}');

      } catch (e) {
        print('🔴 Error procesando ${item.entityType} ${item.entityId}: $e');

        await outboxDao.incrementAttempts(item.id);
        if (item.attempts + 1 >= 5) {
          await outboxDao.markAsFailed(item.id);
        }
        failed++;
      }
    }

    // ── 2. Subir media — SOLO si el outbox quedó vacío ────────────────
    // Las fotos dependen de que la inspección ya exista en el servidor
    final remaining = await outboxDao.getPendingItems();
    if (remaining.isEmpty) {
      try {
        await _uploadPendingMedia();
      } catch (e) {
        print('🔴 Error en uploadMedia: $e');
      }
    } else {
      print('⚠️ Hay items pendientes en outbox, postergando upload de media');
    }

    // ── 3. Pull de activos ────────────────────────────────────────────
    try {
      print('🔵 Iniciando pull de activos...');
      await _pullAssets();
      print('✅ Pull completado');
    } catch (e) {
      print('🔴 Error en pullAssets: $e');
    }

    return SyncResult(synced: synced, failed: failed);
  }

  Future<void> _processItem(OutboxTableData item) async {
    switch (item.entityType) {
      case 'inspection':
        await _syncInspection(item);
      case 'asset':
        await _syncAsset(item);
    }
  }

  // ── Inspecciones ────────────────────────────────────────────────────────────

  Future<void> _syncInspection(OutboxTableData item) async {

    final payload = jsonDecode(item.payload);
    print('📤 Payload inspección: ${jsonEncode(payload)}');

    await inspectionsDao.updateSyncStatus(item.entityId, 'pending');
    await dio.post('/inspections/sync', data: {
      'inspections': [jsonDecode(item.payload)],
    });
    await inspectionsDao.updateSyncStatus(item.entityId, 'synced');
  }

  // ── Activos ─────────────────────────────────────────────────────────────────

  Future<void> _syncAsset(OutboxTableData item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;

    // Verificar si ya existe en el servidor (por local_uuid)
    // POST /assets — el backend devuelve el activo creado con su ID real
    final response = await dio.post('/assets', data: {
      'name': payload['name'],
      'type': payload['type'],
      'location': payload['location'],
      'serial_number': payload['serial_number'],
      'description': payload['description'],
    });

    final remoteId = response.data['id'].toString();
    final localUuid = payload['local_uuid'] as String;

    // Actualizar el registro local: reemplazar el UUID temporal por el ID real
    await assetsDao.updateRemoteId(
      localUuid: localUuid,
      remoteId: remoteId,
      syncedAt: DateTime.now(),
    );
  }

  // ── Pull de activos desde el servidor ───────────────────────────────────────

  Future<void> _pullAssets() async {
    final response = await dio.get('/assets');
    final List<dynamic> data = response.data;

    final companions = data.map((a) {
      return AssetsTableCompanion.insert(
        remoteId: a['id'].toString(),
        name: a['name'] as String,
        type: a['type'] as String,
        location: a['location'] as String? ?? '',
        serialNumber: Value(a['serial_number'] as String?),
        description: Value(a['description'] as String?),
        syncedAt: Value(DateTime.now()),
      );
    }).toList();

    if (companions.isNotEmpty) {
      await assetsDao.upsertAssets(companions);
    }
  }

  Future<void> _uploadPendingMedia() async {
    // 🆕 PASO 1: Limpiar huérfanas y archivos faltantes
    print('🧹 Limpiando fotos huérfanas...');
    final orphansDeleted = await mediaDao.deleteOrphanMedia();
    if (orphansDeleted > 0) {
      print('✅ Eliminadas $orphansDeleted fotos huérfanas');
    }

    await mediaDao.cleanOrphanFiles();

    // PASO 2: Subir las que quedan
    final pendingFiles = await mediaDao.getPendingUploads();
    print('📸 Media pendiente: ${pendingFiles.length} archivos');

    for (final media in pendingFiles) {
      try {
        final file = File(media.localPath);
        if (!await file.exists()) {
          print('⚠️ Archivo no encontrado (no debería pasar): ${media.localPath}');
          await mediaDao.deleteByInspectionUuid(media.inspectionUuid);
          continue;
        }

        final localUuid = const Uuid().v4();

        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            media.localPath,
            filename: media.localPath.split('/').last,
          ),
          'local_uuid': localUuid,
          'inspection_uuid': media.inspectionUuid,
          'field_id': media.fieldId,
          'type': 'photo',
        });

        final response = await dio.post('/media/upload', data: formData);
        final remoteUrl = response.data['url'] as String;

        await mediaDao.markAsUploaded(media.id, remoteUrl);
        print('✅ Foto subida: $remoteUrl');

      } catch (e) {
        if (e is DioException) {
          if (e.response?.statusCode == 404) {
            // 404 = La inspección no existe en el servidor
            print('⚠️ Inspección ${media.inspectionUuid} no existe en servidor');
            print('   Eliminando fotos huérfanas asociadas...');
            await mediaDao.deleteByInspectionUuid(media.inspectionUuid);
          } else {
            print('🔴 Error subiendo foto ${media.id}: ${e.response?.statusCode} - ${e.message}');
          }
        } else {
          print('🔴 Error inesperado subiendo foto ${media.id}: $e');
        }
      }
    }
  }

}

class SyncResult {
  final int synced;
  final int failed;
  const SyncResult({required this.synced, required this.failed});
}