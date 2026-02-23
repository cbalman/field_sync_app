import 'dart:convert';

class FormSchema {
  final String formId;
  final int version;
  final String title;
  final List<FormSection> sections;

  const FormSchema({
    required this.formId,
    required this.version,
    required this.title,
    required this.sections,
  });

  factory FormSchema.fromJson(Map<String, dynamic> json) => FormSchema(
    formId: json['form_id'] as String,
    version: json['version'] as int? ?? 1,
    title: json['title'] as String,
    sections: (json['sections'] as List)
        .map((s) => FormSection.fromJson(s as Map<String, dynamic>))
        .toList(),
  );

  static FormSchema fromJsonString(String raw) =>
      FormSchema.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

class FormSection {
  final String id;
  final String title;
  final List<InspectionField> fields;

  const FormSection({
    required this.id,
    required this.title,
    required this.fields,
  });

  factory FormSection.fromJson(Map<String, dynamic> json) => FormSection(
    id: json['id'] as String,
    title: json['title'] as String,
    fields: (json['fields'] as List)
        .map((f) => InspectionField.fromJson(f as Map<String, dynamic>))
        .toList(),
  );
}

class InspectionField {
  final String id;
  final FieldType type;
  final String label;
  final String? hint;
  final bool required;
  final List<SelectOption>? options;
  final FieldValidation? validation;
  final VisibleWhen? visibleWhen;
  final int? maxFiles;

  const InspectionField({
    required this.id,
    required this.type,
    required this.label,
    this.hint,
    this.required = false,
    this.options,
    this.validation,
    this.visibleWhen,
    this.maxFiles,
  });

  factory InspectionField.fromJson(Map<String, dynamic> json) => InspectionField(
    id: json['id'] as String,
    type: FieldType.fromString(json['type'] as String),
    label: json['label'] as String,
    hint: json['hint'] as String?,
    required: json['required'] as bool? ?? false,
    options: (json['options'] as List?)
        ?.map((o) => SelectOption.fromJson(o as Map<String, dynamic>))
        .toList(),
    validation: json['validation'] != null
        ? FieldValidation.fromJson(
        json['validation'] as Map<String, dynamic>)
        : null,
    visibleWhen: json['visible_when'] != null
        ? VisibleWhen.fromJson(
        json['visible_when'] as Map<String, dynamic>)
        : null,
    maxFiles: json['max_files'] as int?,
  );
}

enum FieldType {
  text,
  textarea,
  number,
  select,
  multiselect,
  boolean,
  date,
  photo,
  signature;

  static FieldType fromString(String value) {
    return FieldType.values.firstWhere(
          (e) => e.name == value,
      orElse: () => FieldType.text,
    );
  }
}

class SelectOption {
  final String value;
  final String label;

  const SelectOption({required this.value, required this.label});

  factory SelectOption.fromJson(Map<String, dynamic> json) => SelectOption(
    value: json['value'] as String,
    label: json['label'] as String,
  );
}

class FieldValidation {
  final num? min;
  final num? max;
  final int? minLength;
  final int? maxLength;

  const FieldValidation({this.min, this.max, this.minLength, this.maxLength});

  factory FieldValidation.fromJson(Map<String, dynamic> json) =>
      FieldValidation(
        min: json['min'] as num?,
        max: json['max'] as num?,
        minLength: json['min_length'] as int?,
        maxLength: json['max_length'] as int?,
      );
}

class VisibleWhen {
  final String field;
  final dynamic equals;

  const VisibleWhen({required this.field, required this.equals});

  factory VisibleWhen.fromJson(Map<String, dynamic> json) => VisibleWhen(
    field: json['field'] as String,
    equals: json['equals'],
  );

  bool evaluate(Map<String, dynamic> formData) {
    final value = formData[field];
    return value == equals;
  }
}