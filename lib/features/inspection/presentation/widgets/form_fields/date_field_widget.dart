import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/form_schema.dart';

class DateFieldWidget extends StatelessWidget {
  final InspectionField field;
  final DateTime? value;
  final String? error;
  final ValueChanged<DateTime?> onChanged;

  const DateFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: field.label + (field.required ? ' *' : ''),
          errorText: error,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          value != null
              ? DateFormat('dd/MM/yyyy').format(value!)
              : 'Seleccionar fecha',
          style: TextStyle(
            color: value != null ? Colors.black87 : Colors.grey,
          ),
        ),
      ),
    );
  }
}
