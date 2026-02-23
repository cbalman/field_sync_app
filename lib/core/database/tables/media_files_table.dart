import 'package:drift/drift.dart';

class MediaFilesTable extends Table {
  @override
  String get tableName => 'media_files';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get inspectionUuid => text()();
  TextColumn get fieldId => text()();        // a qué campo del form pertenece
  TextColumn get localPath => text()();      // ruta absoluta en el device
  TextColumn get compressedPath => text().nullable()();
  TextColumn get remoteUrl => text().nullable()();
  BoolColumn get isUploaded => boolean().withDefault(const Constant(false))();
  IntColumn get fileSizeBytes => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
