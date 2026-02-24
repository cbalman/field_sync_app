import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/inspections_table.dart';

part 'inspections_dao.g.dart';

@DriftAccessor(tables: [InspectionsTable])
class InspectionsDao extends DatabaseAccessor<AppDatabase>
    with _$InspectionsDaoMixin {
  InspectionsDao(super.db);

  Future<List<InspectionsTableData>> getAllInspections() =>
      select(inspectionsTable).get();

  Stream<List<InspectionsTableData>> watchPendingInspections() {
    return (select(inspectionsTable)
      ..where((t) =>
      t.syncStatus.equals('local') | t.syncStatus.equals('pending')))
        .watch();
  }

  Future<InspectionsTableData?> getByUuid(String uuid) {
    return (select(inspectionsTable)
      ..where((t) => t.localUuid.equals(uuid)))
        .getSingleOrNull();
  }

  Future<int> insertInspection(InspectionsTableCompanion inspection) =>
      into(inspectionsTable).insert(inspection);

  Future<void> updateSyncStatus(String uuid, String status) async {
    await (update(inspectionsTable)
      ..where((t) => t.localUuid.equals(uuid)))
        .write(InspectionsTableCompanion(
      syncStatus: Value(status),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Stream<int> watchPendingCount() {
    final countExp = inspectionsTable.id.count();
    final query = selectOnly(inspectionsTable)
      ..addColumns([countExp])
      ..where(inspectionsTable.syncStatus.equals('local') |
      inspectionsTable.syncStatus.equals('pending'));
    return query.map((row) => row.read(countExp) ?? 0).watchSingle();
  }

  Stream<List<InspectionsTableData>> watchInspectionsByAsset(String assetRemoteId) {
    return (select(inspectionsTable)
      ..where((t) => t.assetRemoteId.equals(assetRemoteId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

}
