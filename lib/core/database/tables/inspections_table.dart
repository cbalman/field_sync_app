import 'package:drift/drift.dart';

class InspectionsTable extends Table {
  @override
  String get tableName => 'inspections';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get localUuid => text()();         // UUID generado en el device
  TextColumn get remoteId => text().nullable()(); // null hasta que se sincronice
  TextColumn get assetRemoteId => text()();
  TextColumn get formId => text()();
  IntColumn get formVersion => integer()();
  TextColumn get technicianDeviceId => text()();
  TextColumn get formData => text()();          // JSON con las respuestas
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  // syncStatus: local | pending | synced | conflict | failed
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
