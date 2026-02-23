import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/form_schema.dart';

class NumberFieldWidget extends StatelessWidget {
  final InspectionField field;
  final num? value;
  final String? error;
  final ValueChanged<num?> onChanged;

  const NumberFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value?.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
      ],
      decoration: InputDecoration(
        labelText: field.label + (field.required ? ' *' : ''),
        hintText: field.hint ??
            (field.validation != null
                ? 'Min: ${field.validation!.min ?? "—"} / Max: ${field.validation!.max ?? "—"}'
                : null),
        errorText: error,
      ),
      onChanged: (v) => onChanged(num.tryParse(v)),
    );
  }
}
