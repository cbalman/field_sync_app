import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/asset_detail_provider.dart';
import '../providers/create_asset_provider.dart';

class AssetDetailScreen extends ConsumerStatefulWidget {
  final String assetId;
  const AssetDetailScreen({super.key, required this.assetId});

  @override
  ConsumerState<AssetDetailScreen> createState() => _AssetDetailScreenState();
}

class _AssetDetailScreenState extends ConsumerState<AssetDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Intentar refrescar desde API al abrir (si hay conexión)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isOnline =
          ref.read(connectivityStreamProvider).valueOrNull ?? false;
      if (isOnline) {
        ref
            .read(assetDetailNotifierProvider.notifier)
            .refreshFromApi(widget.assetId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final assetAsync = ref.watch(assetDetailProvider(widget.assetId));
    final inspectionsAsync =
    ref.watch(assetInspectionsProvider(widget.assetId));
    final hasPendingSync =
    ref.watch(assetHasPendingSyncProvider(widget.assetId));
    final isOnline =
        ref.watch(connectivityStreamProvider).valueOrNull ?? false;
    final refreshState = ref.watch(assetDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: assetAsync.when(
          data: (asset) => Text(asset?.name ?? 'Detalle'),
          loading: () => const Text('Cargando...'),
          error: (_, __) => const Text('Activo'),
        ),
        actions: [
          // Botón refresh manual
          if (isOnline)
            IconButton(
              icon: refreshState.isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
                  : const Icon(Icons.refresh),
              onPressed: refreshState.isLoading
                  ? null
                  : () => ref
                  .read(assetDetailNotifierProvider.notifier)
                  .refreshFromApi(widget.assetId),
            ),
        ],
      ),
      body: assetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (asset) {
          if (asset == null) {
            return const Center(child: Text('Activo no encontrado'));
          }
          return RefreshIndicator(
            onRefresh: () => ref
                .read(assetDetailNotifierProvider.notifier)
                .refreshFromApi(widget.assetId),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ── Estado sync ────────────────────────────────────────
                hasPendingSync.when(
                  data: (isPending) => isPending
                      ? _SyncPendingBanner()
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                // ── Info del activo ────────────────────────────────────
                _AssetInfoCard(asset: asset),
                const SizedBox(height: 16),

                // ── Botón nueva inspección ─────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        context.push('/inspection/${widget.assetId}'),
                    icon: const Icon(Icons.assignment_add),
                    label: const Text('Nueva Inspección'),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Historial ──────────────────────────────────────────
                const Text(
                  'Historial de inspecciones',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),

                inspectionsAsync.when(
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                  data: (inspections) {
                    if (inspections.isEmpty) {
                      return _EmptyInspections();
                    }
                    return Column(
                      children: inspections
                          .map((i) => _InspectionCard(inspection: i))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Banner sync pendiente ─────────────────────────────────────────────────────

class _SyncPendingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.pending.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.pending.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.cloud_upload_outlined,
              color: AppColors.pending, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Cambios pendientes de sincronización con el servidor.',
              style: TextStyle(fontSize: 13, color: AppColors.pending),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card info del activo ──────────────────────────────────────────────────────

class _AssetInfoCard extends StatelessWidget {
  final AssetsTableData asset;
  const _AssetInfoCard({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con ícono y tipo
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(_iconForType(asset.type),
                      color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        asset.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        _labelForType(asset.type),
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 24),

            // Campos
            if (asset.location != null && asset.location!.isNotEmpty)
              _InfoRow(
                  icon: Icons.location_on_outlined, label: asset.location!),
            if (asset.serialNumber != null)
              _InfoRow(
                  icon: Icons.qr_code_outlined,
                  label: 'S/N: ${asset.serialNumber}'),
            if (asset.description != null && asset.description!.isNotEmpty)
              _InfoRow(
                  icon: Icons.notes_outlined, label: asset.description!),
            if (asset.lastServiceAt != null)
              _InfoRow(
                icon: Icons.build_outlined,
                label:
                'Último servicio: ${DateFormat('dd/MM/yyyy').format(asset.lastServiceAt!)}',
              ),

            const Divider(height: 24),

            // Estado sync
            Row(
              children: [
                Icon(
                  asset.syncedAt != null
                      ? Icons.cloud_done
                      : Icons.cloud_off_outlined,
                  size: 16,
                  color: asset.syncedAt != null
                      ? AppColors.synced
                      : Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  asset.syncedAt != null
                      ? 'Sincronizado ${DateFormat('dd/MM/yy HH:mm').format(asset.syncedAt!.toLocal())}'
                      : 'Sin sincronizar — solo local',
                  style: TextStyle(
                    fontSize: 12,
                    color: asset.syncedAt != null
                        ? AppColors.synced
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    return switch (type.toLowerCase()) {
      'vehicle' || 'vehiculo' => Icons.directions_car,
      'machinery' || 'maquinaria' => Icons.precision_manufacturing,
      'electrical' || 'electrico' => Icons.electrical_services,
      'infrastructure' => Icons.business,
      _ => Icons.inventory_2,
    };
  }

  String _labelForType(String type) {
    return switch (type.toLowerCase()) {
      'vehicle' || 'vehiculo' => 'Vehículo',
      'machinery' || 'maquinaria' => 'Maquinaria',
      'electrical' || 'electrico' => 'Eléctrico',
      'infrastructure' => 'Infraestructura',
      _ => 'Otro',
    };
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade500),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

// ── Card de inspección ────────────────────────────────────────────────────────

class _InspectionCard extends StatelessWidget {
  final InspectionsTableData inspection;
  const _InspectionCard({required this.inspection});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yy HH:mm');
    final statusColor = switch (inspection.syncStatus) {
      'synced' => AppColors.synced,
      'pending' || 'local' => AppColors.pending,
      'failed' => AppColors.failed,
      _ => Colors.grey,
    };
    final statusLabel = switch (inspection.syncStatus) {
      'synced' => 'Sincronizado',
      'local' => 'Solo local',
      'pending' => 'Pendiente',
      'failed' => 'Fallido',
      _ => inspection.syncStatus,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor.withOpacity(0.3)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.assignment, color: AppColors.secondary),
        ),
        title: Text(
          fmt.format(inspection.createdAt.toLocal()),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Form: ${inspection.formId}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyInspections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.assignment_outlined,
                size: 56, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'Sin inspecciones aún',
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const SizedBox(height: 4),
            Text(
              'Tocá "Nueva Inspección" para comenzar',
              style:
              TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
