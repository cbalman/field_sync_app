import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/form_schema.dart';
import '../../../../../shared/theme/app_theme.dart';

class PhotoFieldWidget extends StatelessWidget {
  final InspectionField field;
  final List<String>? value;
  final String? error;
  final ValueChanged<List<String>> onChanged;

  const PhotoFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final source = Platform.isMacOS || Platform.isWindows || Platform.isLinux
        ? ImageSource.gallery
        : ImageSource.camera;
    final picked = await picker.pickImage(source: source, imageQuality: 80);
    if (picked != null) {
      final current = List<String>.from(value ?? []);
      current.add(picked.path);
      onChanged(current);
    }
  }

  @override
  Widget build(BuildContext context) {
    final photos = value ?? [];
    final maxFiles = field.maxFiles ?? 5;
    final canAdd = photos.length < maxFiles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label + (field.required ? ' *' : ''),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...photos.asMap().entries.map((e) => _PhotoThumb(
              path: e.value,
              onRemove: () {
                final updated = List<String>.from(photos)
                  ..removeAt(e.key);
                onChanged(updated);
              },
            )),
            if (canAdd)
              GestureDetector(
                onTap: () => _pickImage(context),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.primary, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primary.withOpacity(0.05),
                  ),
                  child: const Icon(Icons.add_a_photo,
                      color: AppColors.primary),
                ),
              ),
          ],
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(error!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error, fontSize: 12)),
          ),
        Text(
          '${photos.length}/$maxFiles fotos',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  final String path;
  final VoidCallback onRemove;

  const _PhotoThumb({required this.path, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(path,
              width: 80, height: 80, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade200,
                child: const Icon(Icons.broken_image),
              )),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child:
              const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}
