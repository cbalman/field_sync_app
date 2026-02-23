import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/form_schema.dart';

part 'form_state_notifier.g.dart';

class FormState {
  final Map<String, dynamic> data;
  final Map<String, String?> errors;
  final bool isSubmitting;

  const FormState({
    required this.data,
    required this.errors,
    this.isSubmitting = false,
  });

  FormState copyWith({
    Map<String, dynamic>? data,
    Map<String, String?>? errors,
    bool? isSubmitting,
  }) =>
      FormState(
        data: data ?? this.data,
        errors: errors ?? this.errors,
        isSubmitting: isSubmitting ?? this.isSubmitting,
      );
}

@riverpod
class FormStateNotifier extends _$FormStateNotifier {
  @override
  FormState build(String formId) {
    return const FormState(data: {}, errors: {});
  }

  void setValue(String fieldId, dynamic value) {
    state = state.copyWith(
      data: {...state.data, fieldId: value},
      errors: {...state.errors, fieldId: null},
    );
  }

  void setError(String fieldId, String? error) {
    state = state.copyWith(
      errors: {...state.errors, fieldId: error},
    );
  }

  bool validate(List<FormSection> sections, Map<String, dynamic> currentData) {
    final newErrors = <String, String?>{};
    bool isValid = true;

    for (final section in sections) {
      for (final field in section.fields) {
        // Si el campo no es visible, no validar
        if (field.visibleWhen != null &&
            !field.visibleWhen!.evaluate(currentData)) {
          continue;
        }

        final value = currentData[field.id];
        final isEmpty = value == null ||
            (value is String && value.isEmpty) ||
            (value is List && value.isEmpty);

        if (field.required && isEmpty) {
          newErrors[field.id] = 'Este campo es obligatorio';
          isValid = false;
          continue;
        }

        if (value != null && field.validation != null) {
          final v = field.validation!;
          if (field.type == FieldType.number && value is num) {
            if (v.min != null && value < v.min!) {
              newErrors[field.id] = 'Mínimo: ${v.min}';
              isValid = false;
            } else if (v.max != null && value > v.max!) {
              newErrors[field.id] = 'Máximo: ${v.max}';
              isValid = false;
            }
          }
          if (value is String) {
            if (v.minLength != null && value.length < v.minLength!) {
              newErrors[field.id] = 'Mínimo ${v.minLength} caracteres';
              isValid = false;
            } else if (v.maxLength != null && value.length > v.maxLength!) {
              newErrors[field.id] = 'Máximo ${v.maxLength} caracteres';
              isValid = false;
            }
          }
        }
      }
    }

    state = state.copyWith(errors: newErrors);
    return isValid;
  }

  void reset() {
    state = const FormState(data: {}, errors: {});
  }
}
