import 'package:drift/drift.dart';

class AssetsTable extends Table {
  @override
  String get tableName => 'assets';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get remoteId => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get location => text()();
  TextColumn get serialNumber => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get lastServiceAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
