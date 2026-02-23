import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/router/app_router.dart';
import '../../../../shared/theme/app_theme.dart';

class AssetsScreen extends HookConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    final assetsDao = ref.watch(assetsDaoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activos'),
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar activo...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.value.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    searchQuery.value = '';
                  },
                )
                    : null,
              ),
              onChanged: (v) => searchQuery.value = v,
            ),
          ),

          // Lista
          Expanded(
            child: StreamBuilder<List<AssetsTableData>>(
              stream: searchQuery.value.isEmpty
                  ? assetsDao.watchAllAssets()
                  : assetsDao.watchAllAssets().map(
                    (assets) => assets
                    .where((a) =>
                a.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
                    (a.location ?? '').toLowerCase().contains(searchQuery.value.toLowerCase()))
                    .toList(),
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final assets = snapshot.data ?? [];

                if (assets.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          searchQuery.value.isEmpty
                              ? 'No hay activos cargados'
                              : 'No se encontraron resultados',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        if (searchQuery.value.isEmpty) ...[
                          const SizedBox(height: 8),
                          const Text(
                            'Se cargarán al sincronizar con el servidor',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ]
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: assets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final asset = assets[index];
                    return _AssetCard(asset: asset);
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Botón para agregar activo manual (offline)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/assets/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo activo'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

class _AssetCard extends StatelessWidget {
  final AssetsTableData asset;

  const _AssetCard({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(_getIconForType(asset.type),
              color: AppColors.primary),
        ),
        title: Text(
          asset.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (asset.location != null)
              Text(asset.location!,
                  style: const TextStyle(fontSize: 12)),
            Text(
              asset.type,
              style: TextStyle(
                  fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go('/assets/${asset.remoteId ?? asset.id.toString()}'),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'vehicle':
      case 'vehiculo':
        return Icons.directions_car;
      case 'machinery':
      case 'maquinaria':
        return Icons.precision_manufacturing;
      case 'electrical':
      case 'electrico':
        return Icons.electrical_services;
      default:
        return Icons.inventory_2;
    }
  }
}
