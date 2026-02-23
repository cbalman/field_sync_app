import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user_model.dart';
import '../data/auth_repository.dart';

part 'auth_notifier.g.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? token;
  final String? error;

  const AuthState({
    required this.status,
    this.user,
    this.token,
    this.error,
  });

  const AuthState.loading() : this(status: AuthStatus.loading);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);
  const AuthState.authenticated({required UserModel user, required String token})
      : this(status: AuthStatus.authenticated, user: user, token: token);
  const AuthState.error(String message)
      : this(status: AuthStatus.unauthenticated, error: message);
}

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // TODO: reemplazar con _tryAutoLogin() cuando tengamos backend
    return AuthState.authenticated(
      user: UserModel(
        remoteId: '1',
        name: 'Juan Técnico',
        email: 'juan@test.com',
        role: 'technician',
        deviceId: 'test-device-123',
      ),
      token: 'fake-token',
    );
  }

  // AuthState build() {
  //   _tryAutoLogin();
  //   return const AuthState.loading();
  // }

  Future<void> _tryAutoLogin() async {
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.tryAutoLogin();

    if (result != null) {
      state = AuthState.authenticated(user: result.user, token: result.token);
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.login(email: email, password: password);
      state = AuthState.authenticated(user: result.user, token: result.token);
    } catch (e) {
      state = AuthState.error('Credenciales inválidas. Verificá tu conexión.');
    }
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AuthState.unauthenticated();
  }
}
