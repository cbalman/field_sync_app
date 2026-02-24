import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/outbox_dao.dart';
import '../../../../core/database/tables/outbox_table.dart';
import '../../../../core/sync/sync_engine.dart';

part 'sync_queue_provider.g.dart';

// ── Stream de items de la outbox (todos, no solo pending) ─────────────────

@riverpod
Stream<List<OutboxTableData>> outboxItemsStream(OutboxItemsStreamRef ref) {
  final dao = ref.watch(outboxDaoProvider);
  return dao.watchAllItems();
}

// ── Contador de pendientes ────────────────────────────────────────────────

@riverpod
Stream<int> outboxPendingCount(OutboxPendingCountRef ref) {
  final dao = ref.watch(outboxDaoProvider);
  return dao.watchPendingCount();
}

// ── Notifier que gestiona la acción de sync manual ────────────────────────

@riverpod
class SyncQueueNotifier extends _$SyncQueueNotifier {
  @override
  AsyncValue<SyncResult?> build() => const AsyncData(null);

  Future<SyncResult> triggerSync() async {
    state = const AsyncLoading();
    final engine = ref.read(syncEngineProvider);
    try {
      final result = await engine.sync();
      state = AsyncData(result);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
