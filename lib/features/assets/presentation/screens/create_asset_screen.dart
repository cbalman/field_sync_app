import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/create_asset_provider.dart';

class CreateAssetScreen extends HookConsumerWidget {
  const CreateAssetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final locationController = useTextEditingController();
    final serialController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedType = useState<String?>(null);

    final notifier = ref.watch(createAssetNotifierProvider.notifier);
    final state = ref.watch(createAssetNotifierProvider);

    ref.listen(createAssetNotifierProvider, (_, next) {
      if (next.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Activo guardado. Se sincronizará cuando haya conexión.'),
            backgroundColor: AppColors.synced,
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Activo'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Banner offline ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'El activo se guarda localmente y se sincroniza con el servidor cuando haya conexión.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Nombre ───────────────────────────────────────────────────
            const _SectionLabel(label: 'Nombre del activo *'),
            const SizedBox(height: 6),
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Ej: Excavadora CAT 320',
                prefixIcon: Icon(Icons.label_outline),
              ),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'El nombre es obligatorio' : null,
            ),

            const SizedBox(height: 20),

            // ── Tipo ─────────────────────────────────────────────────────
            const _SectionLabel(label: 'Tipo de activo *'),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedType.value,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.category_outlined),
                hintText: 'Seleccioná un tipo',
              ),
              items: kAssetTypes
                  .map((t) => DropdownMenuItem(
                value: t.value,
                child: Row(
                  children: [
                    Icon(_iconForType(t.value),
                        size: 18, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Text(t.label),
                  ],
                ),
              ))
                  .toList(),
              onChanged: (v) => selectedType.value = v,
              validator: (v) =>
              v == null ? 'Seleccioná un tipo de activo' : null,
            ),

            const SizedBox(height: 20),

            // ── Ubicación ─────────────────────────────────────────────────
            const _SectionLabel(label: 'Ubicación'),
            const SizedBox(height: 6),
            TextFormField(
              controller: locationController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Ej: Planta Norte - Sector B',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),

            const SizedBox(height: 20),

            // ── Número de serie ───────────────────────────────────────────
            const _SectionLabel(label: 'Número de serie'),
            const SizedBox(height: 6),
            TextFormField(
              controller: serialController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                hintText: 'Ej: SN-2024-0042',
                prefixIcon: Icon(Icons.qr_code_outlined),
              ),
            ),

            const SizedBox(height: 20),

            // ── Descripción ───────────────────────────────────────────────
            const _SectionLabel(label: 'Descripción'),
            const SizedBox(height: 6),
            TextFormField(
              controller: descriptionController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Notas adicionales sobre el activo...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Icon(Icons.notes_outlined),
                ),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 32),

            // ── Botón guardar ─────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: state.isLoading
                    ? null
                    : () {
                  if (formKey.currentState!.validate()) {
                    notifier.createAsset(
                      name: nameController.text.trim(),
                      type: selectedType.value!,
                      location: locationController.text.trim().isEmpty
                          ? null
                          : locationController.text.trim(),
                      serialNumber: serialController.text.trim().isEmpty
                          ? null
                          : serialController.text.trim(),
                      description: descriptionController.text.trim().isEmpty
                          ? null
                          : descriptionController.text.trim(),
                    );
                  }
                },
                icon: state.isLoading
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.save_outlined),
                label: Text(
                  state.isLoading ? 'Guardando...' : 'Guardar activo',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    return switch (type) {
      'vehicle' => Icons.directions_car,
      'machinery' => Icons.precision_manufacturing,
      'electrical' => Icons.electrical_services,
      'infrastructure' => Icons.business,
      _ => Icons.inventory_2,
    };
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
