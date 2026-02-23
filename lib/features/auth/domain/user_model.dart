class UserModel {
  final String remoteId;
  final String name;
  final String email;
  final String role;
  final String deviceId;

  const UserModel({
    required this.remoteId,
    required this.name,
    required this.email,
    required this.role,
    required this.deviceId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    remoteId: json['id'].toString(),
    name: json['name'] as String,
    email: json['email'] as String,
    role: json['role'] as String? ?? 'technician',
    deviceId: json['device_id'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': remoteId,
    'name': name,
    'email': email,
    'role': role,
    'device_id': deviceId,
  };
}
