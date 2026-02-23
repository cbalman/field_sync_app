import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/outbox_table.dart';

part 'outbox_dao.g.dart';

@DriftAccessor(tables: [OutboxTable])
class OutboxDao extends DatabaseAccessor<AppDatabase> with _$OutboxDaoMixin {
  OutboxDao(super.db);

  // Todos los items (pending + failed), para la vista de cola
  Stream<List<OutboxTableData>> watchAllItems() {
    return (select(outboxTable)
      ..where((t) =>
      t.status.equals('pending') | t.status.equals('failed'))
      ..orderBy([
            (t) => OrderingTerm(
          expression: t.status,
          mode: OrderingMode.desc, // 'pending' antes que 'failed'
        ),
            (t) => OrderingTerm.asc(t.createdAt),
      ]))
        .watch();
  }

  Stream<List<OutboxTableData>> watchPendingItems() {
    return (select(outboxTable)
      ..where((t) => t.status.equals('pending'))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .watch();
  }

  Future<List<OutboxTableData>> getPendingItems() {
    return (select(outboxTable)
      ..where((t) =>
      t.status.equals('pending') & t.attempts.isSmallerThanValue(5))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  Future<int> insertItem(OutboxTableCompanion item) =>
      into(outboxTable).insert(item);

  Future<void> incrementAttempts(int id) async {
    final item =
    await (select(outboxTable)..where((t) => t.id.equals(id))).getSingle();
    await (update(outboxTable)..where((t) => t.id.equals(id))).write(
      OutboxTableCompanion(
        attempts: Value(item.attempts + 1),
        lastAttemptAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markAsFailed(int id) async {
    await (update(outboxTable)..where((t) => t.id.equals(id)))
        .write(OutboxTableCompanion(status: Value('failed')));
  }

  Future<void> retryItem(int id) async {
    await (update(outboxTable)..where((t) => t.id.equals(id))).write(
      OutboxTableCompanion(
        status: const Value('pending'),
        attempts: const Value(0),
        lastAttemptAt: const Value.absent(),
      ),
    );
  }

  Future<void> deleteItem(int id) =>
      (delete(outboxTable)..where((t) => t.id.equals(id))).go();

  Future<void> deleteAllFailed() =>
      (delete(outboxTable)..where((t) => t.status.equals('failed'))).go();

  Stream<int> watchPendingCount() {
    final countExp = outboxTable.id.count();
    final query = selectOnly(outboxTable)
      ..addColumns([countExp])
      ..where(outboxTable.status.equals('pending'));
    return query.map((row) => row.read(countExp) ?? 0).watchSingle();
  }
}