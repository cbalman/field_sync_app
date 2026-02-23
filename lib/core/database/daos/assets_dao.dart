import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/assets_table.dart';

part 'assets_dao.g.dart';

@DriftAccessor(tables: [AssetsTable])
class AssetsDao extends DatabaseAccessor<AppDatabase> with _$AssetsDaoMixin {
  AssetsDao(super.db);

  Future<List<AssetsTableData>> getAllAssets() => select(assetsTable).get();
  Stream<List<AssetsTableData>> watchAllAssets() => select(assetsTable).watch();

  Future<List<AssetsTableData>> searchAssets(String query) {
    return (select(assetsTable)
      ..where((t) =>
      t.name.lower().like('%${query.toLowerCase()}%') |
      t.location.lower().like('%${query.toLowerCase()}%')))
        .get();
  }

  Future<AssetsTableData?> getAssetByRemoteId(String remoteId) {
    return (select(assetsTable)..where((t) => t.remoteId.equals(remoteId)))
        .getSingleOrNull();
  }

  Future<void> upsertAssets(List<AssetsTableCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(assetsTable, rows));
  }

  Future<int> insertAsset(AssetsTableCompanion asset) =>
      into(assetsTable).insert(asset);
}