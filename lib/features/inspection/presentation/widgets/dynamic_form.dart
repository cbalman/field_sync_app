import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/form_schema.dart';
import '../form_state_notifier.dart';
import 'form_fields/text_field_widget.dart';
import 'form_fields/number_field_widget.dart';
import 'form_fields/select_field_widget.dart';
import 'form_fields/boolean_field_widget.dart';
import 'form_fields/date_field_widget.dart';
import 'form_fields/photo_field_widget.dart';
import 'form_fields/signature_field_widget.dart';

class DynamicForm extends ConsumerWidget {
  final FormSchema schema;
  final String formId;
  final VoidCallback? onSubmit;

  const DynamicForm({
    super.key,
    required this.schema,
    required this.formId,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateNotifierProvider(formId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...schema.sections.map((section) => _SectionWidget(
          section: section,
          formId: formId,
          formData: formState.data,
        )),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: formState.isSubmitting
              ? null
              : () {
            final isValid = ref
                .read(formStateNotifierProvider(formId).notifier)
                .validate(schema.sections, formState.data);
            if (isValid) onSubmit?.call();
          },
          child: formState.isSubmitting
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: Colors.white),
          )
              : const Text('Guardar Inspección'),
        ),
      ],
    );
  }
}

class _SectionWidget extends ConsumerWidget {
  final FormSection section;
  final String formId;
  final Map<String, dynamic> formData;

  const _SectionWidget({
    required this.section,
    required this.formId,
    required this.formData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            section.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const Divider(height: 1),
        const SizedBox(height: 12),
        ...section.fields.map((field) {
          // Lógica visible_when
          if (field.visibleWhen != null &&
              !field.visibleWhen!.evaluate(formData)) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildField(field, formId, ref),
          );
        }),
      ],
    );
  }

  Widget _buildField(InspectionField field, String formId, WidgetRef ref) {
    final formState = ref.watch(formStateNotifierProvider(formId));
    final value = formState.data[field.id];
    final error = formState.errors[field.id];
    final notifier = ref.read(formStateNotifierProvider(formId).notifier);

    switch (field.type) {
      case FieldType.text:
      case FieldType.textarea:
        return TextFieldWidget(
          field: field,
          value: value as String?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
        );
      case FieldType.number:
        return NumberFieldWidget(
          field: field,
          value: value as num?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
        );
      case FieldType.select:
        return SelectFieldWidget(
          field: field,
          value: value as String?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
        );
      case FieldType.multiselect:
        return SelectFieldWidget(
          field: field,
          value: value as String?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
          isMulti: true,
        );
      case FieldType.boolean:
        return BooleanFieldWidget(
          field: field,
          value: value as bool?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
        );
      case FieldType.date:
        return DateFieldWidget(
          field: field,
          value: value as DateTime?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
        );
      case FieldType.photo:
        return PhotoFieldWidget(
          field: field,
          value: value as List<String>?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
        );
      case FieldType.signature:
        return SignatureFieldWidget(
          field: field,
          value: value as String?,
          error: error,
          onChanged: (v) => notifier.setValue(field.id, v),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
