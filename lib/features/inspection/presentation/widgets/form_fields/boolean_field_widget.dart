import 'package:flutter/material.dart';
import '../../../domain/form_schema.dart';
import '../../../../../shared/theme/app_theme.dart';

class BooleanFieldWidget extends StatelessWidget {
  final InspectionField field;
  final bool? value;
  final String? error;
  final ValueChanged<bool> onChanged;

  const BooleanFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label + (field.required ? ' *' : ''),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _OptionButton(
              label: 'Sí',
              selected: value == true,
              color: AppColors.synced,
              onTap: () => onChanged(true),
            ),
            const SizedBox(width: 12),
            _OptionButton(
              label: 'No',
              selected: value == false,
              color: AppColors.error,
              onTap: () => onChanged(false),
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
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : Colors.transparent,
          border: Border.all(color: selected ? color : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
