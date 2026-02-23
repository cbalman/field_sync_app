import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/assets_dao.dart';
import '../../../../core/database/daos/outbox_dao.dart';
import '../../../../core/storage/device_id_service.dart';

import 'package:flutter/foundation.dart';
import 'dart:io';

part 'create_asset_provider.g.dart';

// ── Tipos de activo hardcodeados, listos para venir del backend después ───────

class AssetType {
  final String value;
  final String label;
  const AssetType({required this.value, required this.label});
}

const kAssetTypes = [
  AssetType(value: 'vehicle', label: 'Vehículo'),
  AssetType(value: 'machinery', label: 'Maquinaria'),
  AssetType(value: 'electrical', label: 'Eléctrico'),
  AssetType(value: 'infrastructure', label: 'Infraestructura'),
  AssetType(value: 'other', label: 'Otro'),
];

// ── Estado del form ───────────────────────────────────────────────────────────

class CreateAssetState {
  final bool isLoading;
  final String? errorMessage;
  final bool success;

  const CreateAssetState({
    this.isLoading = false,
    this.errorMessage,
    this.success = false,
  });

  CreateAssetState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? success,
  }) {
    return CreateAssetState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      success: success ?? this.success,
    );
  }
}

// ── Notifier ──────────────────────────────────────────────────────────────────

@riverpod
class CreateAssetNotifier extends _$CreateAssetNotifier {
  @override
  CreateAssetState build() => const CreateAssetState();

  Future<void> createAsset({
    required String name,
    required String type,
    String? location,
    String? serialNumber,
    String? description,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final assetsDao = ref.read(assetsDaoProvider);
      final outboxDao = ref.read(outboxDaoProvider);
      final deviceIdService = ref.read(deviceIdServiceProvider);
      final localUuid = const Uuid().v4();
      // final deviceId = await deviceIdService.getOrCreate();
      // final deviceId = (kDebugMode && Platform.isIOS)
      //     ? 'simulator-dev-device'
      //     : await deviceIdService.getOrCreate();
      final deviceId = 'simulator-dev-device';

      final now = DateTime.now();

      // 1. Persistir localmente
      await assetsDao.insertAsset(
        AssetsTableCompanion.insert(
          remoteId: localUuid,
          name: name,
          type: type,
          location: location ?? '',
          serialNumber: Value(serialNumber),
          description: Value(description),
          syncedAt: const Value(null),
          createdAt: Value(now),
        ),
      );

      // 2. Encolar en outbox
      final payload = jsonEncode({
        'local_uuid': localUuid,
        'name': name,
        'type': type,
        'location': location,
        'serial_number': serialNumber,
        'description': description,
        'device_id': deviceId,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      });

      await outboxDao.insertItem(
        OutboxTableCompanion.insert(
          entityType: 'asset',
          entityId: localUuid,
          operation: 'create',
          payload: payload,
          deviceId: deviceId,
        ),
      );

      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error al guardar el activo: $e',
      );
    }
  }
}