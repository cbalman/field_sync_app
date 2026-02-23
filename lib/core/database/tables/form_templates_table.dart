import 'package:drift/drift.dart';

class FormTemplatesTable extends Table {
  @override
  String get tableName => 'form_templates';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get formId => text()();    // ej: "auto_check_v1"
  IntColumn get version => integer()();
  TextColumn get title => text()();
  TextColumn get schema => text()();    // JSON completo del formulario
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();
}
