// test/features/sync_queue/presentation/providers/sync_queue_provider_test.dart
//
// Tests del SyncQueueNotifier usando ProviderContainer (sin Flutter, sin widgets).
// Permite verificar que el estado cambia correctamente al hacer sync.
//
// Para correr:
//   flutter test test/features/sync_queue/presentation/providers/sync_queue_provider_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart'; // agrega mocktail en pubspec.yaml

import 'package:fieldsync_pro/core/sync/sync_engine.dart';
import 'package:fieldsync_pro/features/sync_queue/presentation/providers/sync_queue_provider.dart';

// ─── Mocks ────────────────────────────────────────────────────────────────────
//
// Un "mock" es un objeto falso que reemplaza una dependencia real en los tests.
// Aquí creamos un SyncEngine falso para no necesitar red ni BD real.

class MockSyncEngine extends Mock implements SyncEngine {}

// ─────────────────────────────────────────────────────────────────────────────

void main() {
  late MockSyncEngine mockEngine;

  setUp(() {
    mockEngine = MockSyncEngine();
  });

  // Crea un ProviderContainer con el SyncEngine reemplazado por el mock
  ProviderContainer buildContainer() {
    return ProviderContainer(
      overrides: [
        // Le decimos a Riverpod: "cuando alguien pida syncEngineProvider,
        // devuelve el mockEngine en lugar del real"
        syncEngineProvider.overrideWithValue(mockEngine),
      ],
    );
  }

  group('SyncQueueNotifier', () {
    test('estado inicial es AsyncData(null)', () {
      final container = buildContainer();
      addTearDown(container.dispose);

      final state = container.read(syncQueueNotifierProvider);

      // Al arrancar, el notifier no ha hecho nada todavía
      expect(state, const AsyncData<SyncResult?>(null));
    });

    test('triggerSync() devuelve el resultado del engine', () async {
      final container = buildContainer();
      addTearDown(container.dispose);

      final resultadoEsperado = SyncResult(synced: 3, failed: 0, orphansDeleted: 1);

      // Configuramos el mock para que devuelva un resultado predefinido
      when(() => mockEngine.sync()).thenAnswer((_) async => resultadoEsperado);

      final resultado = await container
          .read(syncQueueNotifierProvider.notifier)
          .triggerSync();

      expect(resultado.synced, 3);
      expect(resultado.failed, 0);
      expect(resultado.orphansDeleted, 1);

      // Verificamos que el estado del provider también se actualizó
      final state = container.read(syncQueueNotifierProvider);
      expect(state.value, resultadoEsperado);
    });

    test('triggerSync() pone el estado en AsyncError si el engine falla', () async {
      final container = buildContainer();
      addTearDown(container.dispose);

      // Configuramos el mock para que lance una excepción
      when(() => mockEngine.sync()).thenThrow(Exception('Sin conexión'));

      await expectLater(
            () => container.read(syncQueueNotifierProvider.notifier).triggerSync(),
        throwsA(isA<Exception>()),
      );

      final state = container.read(syncQueueNotifierProvider);
      expect(state.hasError, true);
    });
  });
}
