// test/features/sync_queue/presentation/screens/sync_queue_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fieldsync_pro/core/database/app_database.dart';
import 'package:fieldsync_pro/core/database/daos/media_dao.dart';
import 'package:fieldsync_pro/core/database/daos/outbox_dao.dart';
import 'package:fieldsync_pro/core/network/connectivity_service.dart';
import 'package:fieldsync_pro/features/sync_queue/presentation/screens/sync_queue_screen.dart';
import 'package:fieldsync_pro/features/sync_queue/presentation/providers/sync_queue_provider.dart';

// Mocks
class MockOutboxDao extends Mock implements OutboxDao {}
class MockMediaDao extends Mock implements MediaDao {}

void main() {
  late MockOutboxDao mockOutboxDao;
  late MockMediaDao mockMediaDao;

  setUp(() {
    mockOutboxDao = MockOutboxDao();
    mockMediaDao = MockMediaDao();

    // Stub streams por defecto
    when(() => mockOutboxDao.watchPendingItems())
        .thenAnswer((_) => Stream.value([]));
    when(() => mockOutboxDao.watchPendingCount())
        .thenAnswer((_) => Stream.value(0));
  });

  ProviderContainer makeContainer() {
    return ProviderContainer(
      overrides: [
        outboxDaoProvider.overrideWithValue(mockOutboxDao),
        mediaDaoProvider.overrideWithValue(mockMediaDao),
        connectivityStreamProvider.overrideWith((ref) => Stream.value(true)),
      ],
    );
  }

  Widget makeTestApp(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        home: SyncQueueScreen(),
      ),
    );
  }

  group('SyncQueueScreen — estructura', () {
    testWidgets('muestra estado cuando hay red', (tester) async {
      final container = makeContainer();
      addTearDown(container.dispose);

      // 🔧 Aumentar tamaño de pantalla
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(makeTestApp(container));
      await tester.pumpAndSettle();

      // 🔧 Buscar el texto correcto
      expect(find.text('Conectado al servidor'), findsOneWidget);
      // O alternativamente por ícono:
      expect(find.byIcon(Icons.cloud_done), findsOneWidget);
    });
  });

  group('SyncQueueScreen — botón limpiar fotos huérfanas', () {
    testWidgets('abre el menú y muestra opción "Limpiar fotos huérfanas"', (tester) async {
      final container = makeContainer();
      addTearDown(container.dispose);

      // 🔧 Aumentar tamaño
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(makeTestApp(container));
      await tester.pumpAndSettle();

      // Abrir menú
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Buscar por ícono (más robusto que por texto)
      expect(find.byIcon(Icons.cleaning_services), findsOneWidget);
    });

    testWidgets('al confirmar el diálogo se llama deleteOrphanMedia()', (tester) async {
      final container = makeContainer();
      addTearDown(container.dispose);

      // Mock del método
      when(() => mockMediaDao.deleteOrphanMedia()).thenAnswer((_) async => 3);
      when(() => mockMediaDao.cleanOrphanFiles()).thenAnswer((_) async {});

      // 🔧 Aumentar tamaño
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(makeTestApp(container));
      await tester.pumpAndSettle();

      // Abrir menú
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Tap en opción
      await tester.tap(find.byIcon(Icons.cleaning_services));
      await tester.pumpAndSettle();

      // Confirmar diálogo
      await tester.tap(find.text('Limpiar'));
      await tester.pumpAndSettle();

      // Verificar que se llamó
      verify(() => mockMediaDao.deleteOrphanMedia()).called(1);
      verify(() => mockMediaDao.cleanOrphanFiles()).called(1);
    });

    testWidgets('muestra snackbar con éxito al eliminar fotos', (tester) async {
      final container = makeContainer();
      addTearDown(container.dispose);

      when(() => mockMediaDao.deleteOrphanMedia()).thenAnswer((_) async => 5);
      when(() => mockMediaDao.cleanOrphanFiles()).thenAnswer((_) async {});

      // 🔧 Aumentar tamaño
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(makeTestApp(container));
      await tester.pumpAndSettle();

      // Abrir menú y confirmar
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.cleaning_services));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Limpiar'));
      await tester.pumpAndSettle();

      // Esperar el SnackBar
      await tester.pump(const Duration(milliseconds: 500));

      // Verificar mensaje
      expect(find.text('✅ Eliminadas 5 fotos huérfanas'), findsOneWidget);
    });

    testWidgets('NO llama al DAO si el usuario cancela el diálogo', (tester) async {
      final container = makeContainer();
      addTearDown(container.dispose);

      // 🔧 Aumentar tamaño
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(makeTestApp(container));
      await tester.pumpAndSettle();

      // Abrir menú
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.cleaning_services));
      await tester.pumpAndSettle();

      // CANCELAR diálogo
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      // Verificar que NO se llamó
      verifyNever(() => mockMediaDao.deleteOrphanMedia());
      verifyNever(() => mockMediaDao.cleanOrphanFiles());
    });
  });
}
