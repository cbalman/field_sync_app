import 'package:drift/drift.dart';

import 'dart:io';

import '../app_database.dart';
import '../tables/media_files_table.dart';
import '../tables/inspections_table.dart';

part 'media_dao.g.dart';

@DriftAccessor(tables: [MediaFilesTable, InspectionsTable])
class MediaDao extends DatabaseAccessor<AppDatabase> with _$MediaDaoMixin {
  MediaDao(AppDatabase db) : super(db);

  Future<List<MediaFilesTableData>> getByInspectionUuid(String uuid) {
    return (select(mediaFilesTable)
      ..where((t) => t.inspectionUuid.equals(uuid)))
        .get();
  }

  Future<List<MediaFilesTableData>> getPendingUploads() {
    return (select(mediaFilesTable)
      ..where((t) => t.isUploaded.equals(false)))
        .get();
  }

  Future<int> insertMedia(MediaFilesTableCompanion media) =>
      into(mediaFilesTable).insert(media);

  Future<void> markAsUploaded(int id, String remoteUrl) async {
    await (update(mediaFilesTable)..where((t) => t.id.equals(id))).write(
      MediaFilesTableCompanion(
        isUploaded: const Value(true),
        remoteUrl: Value(remoteUrl),
      ),
    );
  }

  /// 🆕 Borrar fotos de una inspección específica
  Future<int> deleteByInspectionUuid(String uuid) {
    return (delete(mediaFilesTable)
      ..where((t) => t.inspectionUuid.equals(uuid)))
        .go();
  }

  /// 🆕 Borrar fotos huérfanas (cuya inspección ya no existe localmente)
  Future<int> deleteOrphanMedia() async {
    // 1. Obtener todas las fotos no subidas
    final pendingMedia = await (select(mediaFilesTable)
      ..where((t) => t.isUploaded.equals(false)))
        .get();

    if (pendingMedia.isEmpty) return 0;

    // 2. Obtener UUIDs únicos de inspecciones
    final inspectionUuids = pendingMedia
        .map((m) => m.inspectionUuid)
        .toSet()
        .toList();

    // 3. Verificar cuáles inspecciones existen
    final existingInspections = await (select(inspectionsTable)
      ..where((t) => t.localUuid.isIn(inspectionUuids)))
        .get();

    final existingUuids = existingInspections
        .map((i) => i.localUuid)
        .toSet();

    // 4. Borrar fotos de inspecciones que no existen
    int totalDeleted = 0;
    for (final uuid in inspectionUuids) {
      if (!existingUuids.contains(uuid)) {
        final deleted = await deleteByInspectionUuid(uuid);
        totalDeleted += deleted;
        print('🗑️ Eliminadas $deleted fotos huérfanas de inspección $uuid');
      }
    }

    return totalDeleted;
  }

  /// 🆕 Borrar archivos físicos huérfanos del filesystem
  Future<void> cleanOrphanFiles() async {
    final pendingMedia = await getPendingUploads();

    for (final media in pendingMedia) {
      final file = File(media.localPath);
      if (!await file.exists()) {
        print('🗑️ Archivo físico no existe: ${media.localPath}');
        await (delete(mediaFilesTable)..where((t) => t.id.equals(media.id))).go();
      }
    }
  }

}
