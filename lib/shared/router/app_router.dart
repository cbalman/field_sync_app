import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/auth_notifier.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/inspection/presentation/screens/inspection_screen.dart';
import '../../features/assets/presentation/screens/assets_screen.dart';
import '../../features/sync_queue/presentation/screens/sync_queue_screen.dart';
import '../../features/assets/presentation/screens/create_asset_screen.dart';
import '../../features/assets/presentation/screens/asset_detail_screen.dart';

part 'app_router.g.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const assets = '/assets';
  static const assetDetail = '/assets/:id';
  static const inspection = '/inspection/:assetId';
  static const syncQueue = '/sync-queue';
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoading = authState.status == AuthStatus.loading;
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isOnLogin = state.matchedLocation == AppRoutes.login;
      final isOnSplash = state.matchedLocation == AppRoutes.splash;

      if (isLoading) return AppRoutes.splash;
      if (!isAuthenticated && !isOnLogin) return AppRoutes.login;
      if (isAuthenticated && (isOnLogin || isOnSplash)) return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.assets,
            builder: (context, state) => const AssetsScreen(),
          ),
          GoRoute(
            path: '/assets/new',
            builder: (context, state) => const CreateAssetScreen(),
          ),
          GoRoute(
            path: AppRoutes.assetDetail,
            builder: (context, state) => AssetDetailScreen(
              assetId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: AppRoutes.inspection,
            builder: (context, state) => InspectionScreen(
              assetId: state.pathParameters['assetId']!,
            ),
          ),
          GoRoute(
            path: AppRoutes.syncQueue,
            // ✅ Pantalla real — ya no es un placeholder
            builder: (context, state) => const SyncQueueScreen(),
          ),
        ],
      ),
    ],
  );
}

// ── Splash ────────────────────────────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) context.go(AppRoutes.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

// ── Shell con NavigationBar ───────────────────────────────────────────────────

class MainShell extends ConsumerWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;

    final selectedIndex = switch (true) {
      _ when location.startsWith('/dashboard') => 0,
      _ when location.startsWith('/assets') => 1,
      _ when location.startsWith('/sync-queue') => 2,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Activos',
          ),
          NavigationDestination(
            icon: Icon(Icons.sync_outlined),
            selectedIcon: Icon(Icons.sync),
            label: 'Sync',
          ),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.dashboard);
            case 1:
              context.go(AppRoutes.assets);
            case 2:
              context.go(AppRoutes.syncQueue);
          }
        },
      ),
    );
  }
}
