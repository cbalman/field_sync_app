import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'tables/users_table.dart';
import 'tables/assets_table.dart';
import 'tables/form_templates_table.dart';
import 'tables/inspections_table.dart';
import 'tables/outbox_table.dart';
import 'tables/media_files_table.dart';

import 'daos/assets_dao.dart';
import 'daos/inspections_dao.dart';
import 'daos/outbox_dao.dart';
import 'daos/form_templates_dao.dart';
import 'daos/media_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UsersTable,
    AssetsTable,
    FormTemplatesTable,
    InspectionsTable,
    OutboxTable,
    MediaFilesTable,
  ],
  daos: [
    AssetsDao,
    InspectionsDao,
    OutboxDao,
    FormTemplatesDao,
    MediaDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Acá irán las migraciones futuras
      // ej: if (from < 2) await m.addColumn(...)
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fieldsync.db'));
    return NativeDatabase.createInBackground(file);
  });
}

// Provider global de la base de datos
@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

// Providers de cada DAO para usar directo en los widgets
@Riverpod(keepAlive: true)
AssetsDao assetsDao(AssetsDaoRef ref) =>
    ref.watch(appDatabaseProvider).assetsDao;

@Riverpod(keepAlive: true)
InspectionsDao inspectionsDao(InspectionsDaoRef ref) =>
    ref.watch(appDatabaseProvider).inspectionsDao;

@Riverpod(keepAlive: true)
OutboxDao outboxDao(OutboxDaoRef ref) =>
    ref.watch(appDatabaseProvider).outboxDao;

@Riverpod(keepAlive: true)
FormTemplatesDao formTemplatesDao(FormTemplatesDaoRef ref) =>
    ref.watch(appDatabaseProvider).formTemplatesDao;

@Riverpod(keepAlive: true)
MediaDao mediaDao(MediaDaoRef ref) =>
    ref.watch(appDatabaseProvider).mediaDao;
