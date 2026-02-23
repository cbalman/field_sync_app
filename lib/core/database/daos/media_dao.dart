import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/media_files_table.dart';

part 'media_dao.g.dart';

@DriftAccessor(tables: [MediaFilesTable])
class MediaDao extends DatabaseAccessor<AppDatabase> with _$MediaDaoMixin {
  MediaDao(super.db);

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
}