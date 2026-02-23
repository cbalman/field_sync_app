import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/form_schema.dart';
import '../widgets/dynamic_form.dart';
import '../form_state_notifier.dart';
import '../../../../core/database/app_database.dart';
import '../../../auth/presentation/auth_notifier.dart';

const _testSchemaJson = '''
{
  "form_id": "auto_check_v1",
  "version": 1,
  "title": "Revisión de Vehículo",
  "sections": [
    {
      "id": "sec_general",
      "title": "Datos Generales",
      "fields": [
        {
          "id": "tire_pressure",
          "type": "number",
          "label": "Presión de neumáticos",
          "hint": "Ingrese en PSI",
          "required": true,
          "validation": { "min": 20, "max": 50 }
        },
        {
          "id": "oil_level",
          "type": "select",
          "label": "Nivel de aceite",
          "required": true,
          "options": [
            { "value": "low", "label": "Bajo" },
            { "value": "ok", "label": "Normal" },
            { "value": "high", "label": "Alto" }
          ]
        },
        {
          "id": "damage_found",
          "type": "boolean",
          "label": "¿Se encontraron daños?",
          "required": true
        },
        {
          "id": "damage_description",
          "type": "textarea",
          "label": "Descripción del daño",
          "required": true,
          "visible_when": { "field": "damage_found", "equals": true }
        }
      ]
    },
    {
      "id": "sec_evidencia",
      "title": "Evidencia",
      "fields": [
        {
          "id": "photos",
          "type": "photo",
          "label": "Fotos del estado",
          "max_files": 3,
          "required": false
        },
        {
          "id": "technician_signature",
          "type": "signature",
          "label": "Firma del técnico",
          "required": true
        }
      ]
    }
  ]
}
''';

class InspectionScreen extends ConsumerWidget {
  final String assetId;

  const InspectionScreen({super.key, required this.assetId});

  Future<void> _saveInspection(
      BuildContext context,
      WidgetRef ref,
      FormSchema schema,
      ) async {
    final formData = ref
        .read(formStateNotifierProvider('inspection_$assetId'))
        .data;

    final uuid = const Uuid().v4();
    final now = DateTime.now();
    final user = ref.read(authNotifierProvider).user;

    // 1. Guardar en InspectionsTable
    final inspectionsDao = ref.read(inspectionsDaoProvider);
    await inspectionsDao.insertInspection(
      InspectionsTableCompanion(
        localUuid: Value(uuid),
        assetRemoteId: Value(assetId),
        technicianDeviceId: Value(user?.deviceId ?? ''),
        formId: Value(schema.formId),
        formVersion: Value(schema.version),
        formData: Value(jsonEncode(formData)),
        syncStatus: const Value('local'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    // 2. Agregar a OutboxTable
    final outboxDao = ref.read(outboxDaoProvider);
    await outboxDao.insertItem(
      OutboxTableCompanion(
        entityType: const Value('inspection'),
        entityId: Value(uuid),
        operation: const Value('CREATE'),
        payload: Value(jsonEncode({
          'local_uuid': uuid,
          'asset_id': int.tryParse(assetId) ?? 0,
          'form_id': schema.formId,
          'form_version': schema.version,
          'device_id': user?.deviceId ?? '',
          'form_data': formData,
          'created_at': now.toIso8601String(),
          'updated_at': now.toIso8601String(),
        })),
        deviceId: Value(user?.deviceId ?? ''),
        status: const Value('pending'),
        createdAt: Value(now),
      ),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Inspección guardada — se sincronizará cuando haya conexión'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schema = FormSchema.fromJsonString(_testSchemaJson);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inspección — $assetId'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DynamicForm(
          schema: schema,
          formId: 'inspection_$assetId',
          onSubmit: () => _saveInspection(context, ref, schema),
        ),
      ),
    );
  }
}
