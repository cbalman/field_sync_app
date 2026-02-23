import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user_model.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../core/storage/device_id_service.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final Dio _dio;
  final SecureStorageService _storage;
  final DeviceIdService _deviceIdService;

  AuthRepository(this._dio, this._storage, this._deviceIdService);

  Future<({UserModel user, String token})> login({
    required String email,
    required String password,
  }) async {
    final deviceId = await _deviceIdService.getOrCreate();

    final response = await _dio.post(
      '/api/v1/auth/login',
      data: {
        'email': email,
        'password': password,
        'device_id': deviceId,
      },
    );

    final token = response.data['token'] as String;
    final user = UserModel.fromJson(response.data['user'] as Map<String, dynamic>);

    // Persistimos token y usuario para uso offline
    await _storage.saveToken(token);
    await _storage.saveUser(jsonEncode(user.toJson()));

    return (user: user, token: token);
  }

  Future<({UserModel user, String token})?> tryAutoLogin() async {
    final token = await _storage.getToken();
    final userJson = await _storage.getUser();

    if (token == null || userJson == null) return null;

    final user = UserModel.fromJson(
      jsonDecode(userJson) as Map<String, dynamic>,
    );
    return (user: user, token: token);
  }

  Future<void> logout() async {
    await _storage.clear();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000'));
  final storage = ref.watch(secureStorageServiceProvider);
  final deviceId = ref.watch(deviceIdServiceProvider);
  return AuthRepository(dio, storage, deviceId);
}
