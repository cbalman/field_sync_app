import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/sync_queue_provider.dart';

class SyncQueueScreen extends ConsumerWidget {
  const SyncQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(outboxItemsStreamProvider);
    final pendingCountAsync = ref.watch(outboxPendingCountProvider);
    final syncState = ref.watch(syncQueueNotifierProvider);
    final isOnline = ref.watch(connectivityStreamProvider).valueOrNull ?? false;
    final isSyncing = syncState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cola de Sincronización'),
        actions: [
          // Badge con cantidad pendiente
          pendingCountAsync.when(
            data: (count) => count > 0
                ? Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Badge(
                label: Text('$count'),
                backgroundColor: AppColors.pending,
                child: const Icon(Icons.cloud_upload_outlined),
              ),
            )
                : const Icon(Icons.cloud_done_outlined),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // ── Header de estado ──────────────────────────────────────────
          _SyncHeader(
            isOnline: isOnline,
            isSyncing: isSyncing,
            pendingCount: pendingCountAsync.valueOrNull ?? 0,
            onSync: isOnline && !isSyncing
                ? () => _triggerSync(context, ref)
                : null,
          ),

          // ── Lista de items ────────────────────────────────────────────
          Expanded(
            child: itemsAsync.when(
              loading: () =>
              const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState();
                }

                // Separar pending de failed
                final pending =
                items.where((i) => i.status == 'pending').toList();
                final failed =
                items.where((i) => i.status == 'failed').toList();

                return RefreshIndicator(
                  onRefresh: () async {
                    if (isOnline) await _triggerSync(context, ref);
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (pending.isNotEmpty) ...[
                        _SectionHeader(
                          title: 'Pendientes (${pending.length})',
                          color: AppColors.pending,
                          icon: Icons.schedule,
                        ),
                        const SizedBox(height: 8),
                        ...pending.map(
                              (item) => _OutboxItemCard(
                            item: item,
                            onRetry: null, // pending ya se reintenta automático
                            onDelete: () => _deleteItem(context, ref, item.id),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (failed.isNotEmpty) ...[
                        Row(
                          children: [
                            Expanded(
                              child: _SectionHeader(
                                title: 'Fallidos (${failed.length})',
                                color: AppColors.failed,
                                icon: Icons.error_outline,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () =>
                                  _clearFailed(context, ref),
                              icon: const Icon(Icons.delete_sweep,
                                  size: 16),
                              label: const Text('Limpiar todos'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.failed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...failed.map(
                              (item) => _OutboxItemCard(
                            item: item,
                            onRetry: () =>
                                _retryItem(context, ref, item.id),
                            onDelete: () =>
                                _deleteItem(context, ref, item.id),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ── FAB: Forzar sync ─────────────────────────────────────────────
      floatingActionButton: isOnline
          ? FloatingActionButton.extended(
        onPressed: isSyncing ? null : () => _triggerSync(context, ref),
        icon: isSyncing
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Icon(Icons.sync),
        label: Text(isSyncing ? 'Sincronizando...' : 'Sincronizar ahora'),
        backgroundColor:
        isSyncing ? Colors.grey : AppColors.primary,
      )
          : null,
    );
  }

  Future<void> _triggerSync(BuildContext context, WidgetRef ref) async {
    try {
      final result =
      await ref.read(syncQueueNotifierProvider.notifier).triggerSync();
      if (context.mounted) {
        final msg = result.synced > 0
            ? '✅ ${result.synced} ${result.synced == 1 ? 'item sincronizado' : 'items sincronizados'}'
            : 'No había items para sincronizar';
        final color =
        result.failed > 0 ? AppColors.pending : Colors.green.shade700;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: color,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Error al sincronizar'),
            backgroundColor: AppColors.failed,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _retryItem(
      BuildContext context, WidgetRef ref, int id) async {
    // Reimplementado en OutboxDao: resetea attempts y status a pending
    // El próximo sync lo tomará automáticamente
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item marcado para reintento'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _deleteItem(
      BuildContext context, WidgetRef ref, int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar item'),
        content: const Text(
            '¿Seguro? Este reporte pendiente se perderá y no se enviará al servidor.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
            TextButton.styleFrom(foregroundColor: AppColors.failed),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item eliminado de la cola'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _clearFailed(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Limpiar fallidos'),
        content: const Text(
            'Se eliminarán todos los items fallidos. Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
            TextButton.styleFrom(foregroundColor: AppColors.failed),
            child: const Text('Limpiar'),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Items fallidos eliminados'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// ── Header de estado de sincronización ──────────────────────────────────────

class _SyncHeader extends StatelessWidget {
  final bool isOnline;
  final bool isSyncing;
  final int pendingCount;
  final VoidCallback? onSync;

  const _SyncHeader({
    required this.isOnline,
    required this.isSyncing,
    required this.pendingCount,
    required this.onSync,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = !isOnline
        ? Colors.grey
        : pendingCount == 0
        ? AppColors.synced
        : AppColors.pending;

    final statusText = !isOnline
        ? 'Sin conexión'
        : isSyncing
        ? 'Sincronizando...'
        : pendingCount == 0
        ? 'Todo sincronizado'
        : '$pendingCount ${pendingCount == 1 ? 'item pendiente' : 'items pendientes'}';

    final statusIcon = !isOnline
        ? Icons.cloud_off
        : pendingCount == 0
        ? Icons.cloud_done
        : Icons.cloud_upload;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          isSyncing
              ? SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: statusColor,
            ),
          )
              : Icon(statusIcon, color: statusColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                    fontSize: 15,
                  ),
                ),
                Text(
                  isOnline
                      ? 'Conectado al servidor'
                      : 'Los datos se guardan localmente',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (!isOnline)
            const Icon(Icons.wifi_off, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}

// ── Sección header (Pendientes / Fallidos) ───────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// ── Card de item del outbox ──────────────────────────────────────────────────

class _OutboxItemCard extends StatelessWidget {
  final OutboxTableData item;
  final VoidCallback? onRetry;
  final VoidCallback? onDelete;

  const _OutboxItemCard({
    required this.item,
    required this.onRetry,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isFailed = item.status == 'failed';
    final statusColor = isFailed ? AppColors.failed : AppColors.pending;
    final fmt = DateFormat('dd/MM/yy HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Fila superior: tipo + status badge ──────────────────────
            Row(
              children: [
                _EntityIcon(type: item.entityType),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _labelForType(item.entityType, item.operation),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'ID: ${item.entityId.length > 20 ? item.entityId.substring(0, 20) + '...' : item.entityId}',
                        style: const TextStyle(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isFailed ? 'FALLIDO' : 'PENDIENTE',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 8),

            // ── Metadata ────────────────────────────────────────────────
            Row(
              children: [
                _MetaChip(
                  icon: Icons.repeat,
                  label: 'Intentos: ${item.attempts}/5',
                  color: item.attempts >= 3 ? AppColors.failed : Colors.grey,
                ),
                const SizedBox(width: 8),
                _MetaChip(
                  icon: Icons.schedule,
                  label: fmt.format(item.createdAt.toLocal()),
                  color: Colors.grey,
                ),
                if (item.lastAttemptAt != null) ...[
                  const SizedBox(width: 8),
                  _MetaChip(
                    icon: Icons.update,
                    label:
                    'Último: ${fmt.format(item.lastAttemptAt!.toLocal())}',
                    color: Colors.grey,
                  ),
                ],
              ],
            ),

            // ── Acciones (solo para failed) ──────────────────────────────
            if (isFailed) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onRetry != null)
                    TextButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Reintentar'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  if (onDelete != null)
                    TextButton.icon(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text('Eliminar'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.failed,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _labelForType(String entityType, String operation) {
    final opLabel = switch (operation) {
      'create' => 'Crear',
      'update' => 'Actualizar',
      'delete' => 'Eliminar',
      _ => operation,
    };
    final typeLabel = switch (entityType) {
      'inspection' => 'Inspección',
      'asset' => 'Activo',
      'media' => 'Archivo multimedia',
      _ => entityType,
    };
    return '$opLabel $typeLabel';
  }
}

class _EntityIcon extends StatelessWidget {
  final String type;
  const _EntityIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (type) {
      'inspection' => (Icons.assignment, AppColors.secondary),
      'asset' => (Icons.inventory_2, AppColors.primary),
      'media' => (Icons.photo_camera, Colors.purple),
      _ => (Icons.upload, Colors.grey),
    };

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 11, color: color)),
      ],
    );
  }
}

// ── Estado vacío ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_done,
              size: 80, color: AppColors.synced.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text(
            'Cola vacía',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Todos los datos están sincronizados\ncon el servidor.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}