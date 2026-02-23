import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/form_templates_table.dart';

part 'form_templates_dao.g.dart';

@DriftAccessor(tables: [FormTemplatesTable])
class FormTemplatesDao extends DatabaseAccessor<AppDatabase>
    with _$FormTemplatesDaoMixin {
  FormTemplatesDao(super.db);

  Future<FormTemplatesTableData?> getActiveTemplate(String formId) {
    return (select(formTemplatesTable)
      ..where((t) => t.formId.equals(formId) & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.version)])
      ..limit(1))
        .getSingleOrNull();
  }

  Future<void> upsertTemplate(FormTemplatesTableCompanion template) async {
    await into(formTemplatesTable).insertOnConflictUpdate(template);
  }

  Future<List<FormTemplatesTableData>> getAllTemplates() =>
      select(formTemplatesTable).get();
}