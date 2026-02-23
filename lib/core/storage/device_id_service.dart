import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'device_id_service.g.dart';

class DeviceIdService {
  static const _key = 'device_id';
  final FlutterSecureStorage _storage;

  DeviceIdService(this._storage);

  Future<String> getOrCreate() async {
    String? existing = await _storage.read(key: _key);
    if (existing != null) return existing;

    final newId = const Uuid().v4();
    await _storage.write(key: _key, value: newId);
    return newId;
  }
}

@Riverpod(keepAlive: true)
DeviceIdService deviceIdService(DeviceIdServiceRef ref) {
  return DeviceIdService(const FlutterSecureStorage());
}