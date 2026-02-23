import 'package:flutter/material.dart';
import '../../../domain/form_schema.dart';

class SelectFieldWidget extends StatelessWidget {
  final InspectionField field;
  final String? value;
  final String? error;
  final ValueChanged<String?> onChanged;
  final bool isMulti;

  const SelectFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
    this.isMulti = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: field.label + (field.required ? ' *' : ''),
        errorText: error,
      ),
      items: field.options
          ?.map((opt) => DropdownMenuItem(
        value: opt.value,
        child: Text(opt.label),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
