import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/assets_dao.dart';
import '../../../../core/database/daos/outbox_dao.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/database/daos/inspections_dao.dart';
import 'package:drift/drift.dart';

part 'asset_detail_provider.g.dart';

// ── Activo local por remoteId ─────────────────────────────────────────────────

@riverpod
Future<AssetsTableData?> assetDetail(AssetDetailRef ref, String assetId) async {
  final dao = ref.watch(assetsDaoProvider);
  return dao.getAssetByRemoteId(assetId);
}

// ── Inspecciones locales del activo (stream reactivo) ────────────────────────

@riverpod
Stream<List<InspectionsTableData>> assetInspections(
    AssetInspectionsRef ref, String assetId) {
  final dao = ref.watch(inspectionsDaoProvider);
  return dao.watchInspectionsByAsset(assetId);
}

// ── Estado del sync del activo en el outbox ───────────────────────────────────

@riverpod
Stream<bool> assetHasPendingSync(AssetHasPendingSyncRef ref, String assetId) {
  final dao = ref.watch(outboxDaoProvider);
  return dao.watchAllItems().map(
        (items) => items.any(
          (i) => i.entityId == assetId && i.status == 'pending',
    ),
  );
}

// ── Refrescar desde la API ────────────────────────────────────────────────────

@riverpod
class AssetDetailNotifier extends _$AssetDetailNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> refreshFromApi(String assetId) async {
    state = const AsyncLoading();
    try {
      final dio = ref.read(dioProvider);
      final assetsDao = ref.read(assetsDaoProvider);

      final response = await dio.get('/assets/$assetId');
      final data = response.data;

      // Actualizar el activo local con los datos frescos del servidor
      await assetsDao.upsertAssets([
        AssetsTableCompanion.insert(
          remoteId: data['id'].toString(),
          name: data['name'],
          type: data['type'],
          location: data['location'] ?? '',
          serialNumber: Value(data['serial_number']),
          description: Value(data['description']),
          syncedAt: Value(DateTime.now()),
        ),
      ]);

      state = const AsyncData(null);
    } on DioException catch (e) {
      // Si falla la API (offline), no es error crítico — tenemos datos locales
      state = AsyncError(e, StackTrace.current);
    }
  }
}
