// test/helpers/database_helpers.dart
//
// Helper compartido para crear una BD en memoria en cualquier test.
// Importa esto en lugar de repetir el código en cada archivo.

import 'package:drift/native.dart';
import 'package:fieldsync_pro/core/database/app_database.dart';

AppDatabase buildTestDatabase() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}