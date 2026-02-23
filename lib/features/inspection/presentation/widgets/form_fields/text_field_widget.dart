import 'package:flutter/material.dart';
import '../../../domain/form_schema.dart';

class TextFieldWidget extends StatelessWidget {
  final InspectionField field;
  final String? value;
  final String? error;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      maxLines: field.type.name == 'textarea' ? 4 : 1,
      decoration: InputDecoration(
        labelText: field.label + (field.required ? ' *' : ''),
        hintText: field.hint,
        errorText: error,
      ),
      onChanged: onChanged,
    );
  }
}
