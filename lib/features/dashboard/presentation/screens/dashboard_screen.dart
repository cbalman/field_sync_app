import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/router/app_router.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../../core/sync/sync_engine.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final connectivityAsync = ref.watch(connectivityStreamProvider);
    final pendingCount = ref.watch(
      inspectionsDaoProvider.select(
            (dao) => dao.watchPendingCount(),
      ),
    );

    final isOnline = connectivityAsync.valueOrNull ?? false;
    final userName = authState.user?.name.split(' ').first ?? 'Técnico';

    return Scaffold(
      appBar: AppBar(
        title: const Text('FieldSync Pro'),
        actions: [
          // Indicador online/offline
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: isOnline
                ? const Chip(
              label: Text('Online', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.green,
            )
                : const Chip(
              label: Text('Offline', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.grey,
            ),
          ),
          // Botón sync manual
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: isOnline ? () => _triggerSync(context, ref) : null,
            tooltip: 'Sincronizar ahora',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Acá irá el trigger de sync manual
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Saludo
            Text(
              '¡Hola, $userName!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _getFormattedDate(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Card de sincronización
            StreamBuilder<int>(
              stream: pendingCount,
              builder: (context, snapshot) {
                final count = snapshot.data ?? 0;
                return _SyncStatusCard(pendingCount: count, isOnline: isOnline);
              },
            ),
            const SizedBox(height: 16),

            // Acciones rápidas
            Text(
              'Acciones rápidas',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.inventory_2_outlined,
                    label: 'Ver Activos',
                    color: AppColors.primary,
                    onTap: () => context.go(AppRoutes.assets),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.sync,
                    label: 'Cola de Sync',
                    color: AppColors.secondary,
                    onTap: () => context.go(AppRoutes.syncQueue),
                  ),
                ),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.assignment,
                    label: 'Form Test',
                    color: Colors.purple,
                    onTap: () => context.go('/inspection/test-asset-123'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Info del dispositivo
            _DeviceInfoCard(
              deviceId: authState.user?.deviceId ?? '—',
              userEmail: authState.user?.email ?? '—',
              userRole: authState.user?.role ?? '—',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _triggerSync(BuildContext context, WidgetRef ref) async {
    final engine = ref.read(syncEngineProvider);
    try {
      final result = await engine.sync();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.synced > 0
                  ? '✅ ${result.synced} inspecciones sincronizadas'
                  : 'No hay pendientes para sincronizar',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Error al sincronizar'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    const months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    const days = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves',
      'Viernes', 'Sábado', 'Domingo'
    ];
    return '${days[now.weekday - 1]}, ${now.day} de ${months[now.month - 1]}';
  }
}

// ── Widgets internos ────────────────────────────────────────────────────────

class _SyncStatusCard extends StatelessWidget {
  final int pendingCount;
  final bool isOnline;

  const _SyncStatusCard({
    required this.pendingCount,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    final color = pendingCount == 0 ? AppColors.synced : AppColors.pending;
    final icon = pendingCount == 0 ? Icons.cloud_done : Icons.cloud_upload;
    final message = pendingCount == 0
        ? 'Todo sincronizado'
        : '$pendingCount ${pendingCount == 1 ? 'reporte pendiente' : 'reportes pendientes'}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    isOnline
                        ? 'Sincronización automática activa'
                        : 'Sin conexión — los datos se guardan localmente',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeviceInfoCard extends StatelessWidget {
  final String deviceId;
  final String userEmail;
  final String userRole;

  const _DeviceInfoCard({
    required this.deviceId,
    required this.userEmail,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Info del dispositivo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 16),
            _InfoRow(label: 'Email', value: userEmail),
            _InfoRow(label: 'Rol', value: userRole),
            _InfoRow(
              label: 'Device ID',
              value: deviceId.length > 16
                  ? '${deviceId.substring(0, 16)}...'
                  : deviceId,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
