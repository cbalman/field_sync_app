import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/app_database.dart';
import '../database/daos/outbox_dao.dart';
import '../database/daos/inspections_dao.dart';
import '../network/dio_provider.dart';

part 'sync_engine.g.dart';

@Riverpod(keepAlive: true)
SyncEngine syncEngine(SyncEngineRef ref) {
  return SyncEngine(
    outboxDao: ref.watch(outboxDaoProvider),
    inspectionsDao: ref.watch(inspectionsDaoProvider),
    dio: ref.watch(dioProvider),
  );
}

class SyncEngine {
  final OutboxDao outboxDao;
  final InspectionsDao inspectionsDao;
  final Dio dio;

  SyncEngine({
    required this.outboxDao,
    required this.inspectionsDao,
    required this.dio,
  });

  Future<SyncResult> sync() async {
    final items = await outboxDao.getPendingItems();

    if (items.isEmpty) return SyncResult(synced: 0, failed: 0);

    int synced = 0;
    int failed = 0;

    for (final item in items) {
      try {
        await _processItem(item);
        await outboxDao.deleteItem(item.id);
        await inspectionsDao.updateSyncStatus(item.entityId, 'synced');
        synced++;
      } catch (e) {
        await outboxDao.incrementAttempts(item.id);
        if (item.attempts + 1 >= 5) {
          await outboxDao.markAsFailed(item.id);
          await inspectionsDao.updateSyncStatus(item.entityId, 'failed');
        }
        failed++;
      }
    }

    return SyncResult(synced: synced, failed: failed);
  }

  Future<void> _processItem(OutboxTableData item) async {
    switch (item.entityType) {
      case 'inspection':
        await _syncInspection(item);
        break;
    }
  }

  Future<void> _syncInspection(OutboxTableData item) async {
    await dio.post('/inspections/sync', data: {
      'inspections': [item.payload],
    });
  }
}

class SyncResult {
  final int synced;
  final int failed;
  const SyncResult({required this.synced, required this.failed});
}