// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, remoteId, name, email, role, deviceId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UsersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  final int id;
  final String remoteId;
  final String name;
  final String email;
  final String role;
  final String deviceId;
  final DateTime createdAt;
  const UsersTableData(
      {required this.id,
      required this.remoteId,
      required this.name,
      required this.email,
      required this.role,
      required this.deviceId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<String>(remoteId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['device_id'] = Variable<String>(deviceId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      name: Value(name),
      email: Value(email),
      role: Value(role),
      deviceId: Value(deviceId),
      createdAt: Value(createdAt),
    );
  }

  factory UsersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<String>(json['remoteId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<String>(remoteId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'deviceId': serializer.toJson<String>(deviceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UsersTableData copyWith(
          {int? id,
          String? remoteId,
          String? name,
          String? email,
          String? role,
          String? deviceId,
          DateTime? createdAt}) =>
      UsersTableData(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        deviceId: deviceId ?? this.deviceId,
        createdAt: createdAt ?? this.createdAt,
      );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, remoteId, name, email, role, deviceId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.name == this.name &&
          other.email == this.email &&
          other.role == this.role &&
          other.deviceId == this.deviceId &&
          other.createdAt == this.createdAt);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<int> id;
  final Value<String> remoteId;
  final Value<String> name;
  final Value<String> email;
  final Value<String> role;
  final Value<String> deviceId;
  final Value<DateTime> createdAt;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersTableCompanion.insert({
    this.id = const Value.absent(),
    required String remoteId,
    required String name,
    required String email,
    required String role,
    required String deviceId,
    this.createdAt = const Value.absent(),
  })  : remoteId = Value(remoteId),
        name = Value(name),
        email = Value(email),
        role = Value(role),
        deviceId = Value(deviceId);
  static Insertable<UsersTableData> custom({
    Expression<int>? id,
    Expression<String>? remoteId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? deviceId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (deviceId != null) 'device_id': deviceId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? remoteId,
      Value<String>? name,
      Value<String>? email,
      Value<String>? role,
      Value<String>? deviceId,
      Value<DateTime>? createdAt}) {
    return UsersTableCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AssetsTableTable extends AssetsTable
    with TableInfo<$AssetsTableTable, AssetsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serialNumberMeta =
      const VerificationMeta('serialNumber');
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
      'serial_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastServiceAtMeta =
      const VerificationMeta('lastServiceAt');
  @override
  late final GeneratedColumn<DateTime> lastServiceAt =
      GeneratedColumn<DateTime>('last_service_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        name,
        type,
        location,
        serialNumber,
        description,
        lastServiceAt,
        syncedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(Insertable<AssetsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('serial_number')) {
      context.handle(
          _serialNumberMeta,
          serialNumber.isAcceptableOrUnknown(
              data['serial_number']!, _serialNumberMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('last_service_at')) {
      context.handle(
          _lastServiceAtMeta,
          lastServiceAt.isAcceptableOrUnknown(
              data['last_service_at']!, _lastServiceAtMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      serialNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}serial_number']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      lastServiceAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_service_at']),
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AssetsTableTable createAlias(String alias) {
    return $AssetsTableTable(attachedDatabase, alias);
  }
}

class AssetsTableData extends DataClass implements Insertable<AssetsTableData> {
  final int id;
  final String remoteId;
  final String name;
  final String type;
  final String location;
  final String? serialNumber;
  final String? description;
  final DateTime? lastServiceAt;
  final DateTime? syncedAt;
  final DateTime createdAt;
  const AssetsTableData(
      {required this.id,
      required this.remoteId,
      required this.name,
      required this.type,
      required this.location,
      this.serialNumber,
      this.description,
      this.lastServiceAt,
      this.syncedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<String>(remoteId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['location'] = Variable<String>(location);
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || lastServiceAt != null) {
      map['last_service_at'] = Variable<DateTime>(lastServiceAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AssetsTableCompanion toCompanion(bool nullToAbsent) {
    return AssetsTableCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      name: Value(name),
      type: Value(type),
      location: Value(location),
      serialNumber: serialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(serialNumber),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lastServiceAt: lastServiceAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastServiceAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      createdAt: Value(createdAt),
    );
  }

  factory AssetsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetsTableData(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<String>(json['remoteId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      location: serializer.fromJson<String>(json['location']),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      description: serializer.fromJson<String?>(json['description']),
      lastServiceAt: serializer.fromJson<DateTime?>(json['lastServiceAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<String>(remoteId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'location': serializer.toJson<String>(location),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'description': serializer.toJson<String?>(description),
      'lastServiceAt': serializer.toJson<DateTime?>(lastServiceAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AssetsTableData copyWith(
          {int? id,
          String? remoteId,
          String? name,
          String? type,
          String? location,
          Value<String?> serialNumber = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<DateTime?> lastServiceAt = const Value.absent(),
          Value<DateTime?> syncedAt = const Value.absent(),
          DateTime? createdAt}) =>
      AssetsTableData(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        name: name ?? this.name,
        type: type ?? this.type,
        location: location ?? this.location,
        serialNumber:
            serialNumber.present ? serialNumber.value : this.serialNumber,
        description: description.present ? description.value : this.description,
        lastServiceAt:
            lastServiceAt.present ? lastServiceAt.value : this.lastServiceAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  AssetsTableData copyWithCompanion(AssetsTableCompanion data) {
    return AssetsTableData(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      location: data.location.present ? data.location.value : this.location,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      description:
          data.description.present ? data.description.value : this.description,
      lastServiceAt: data.lastServiceAt.present
          ? data.lastServiceAt.value
          : this.lastServiceAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetsTableData(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('location: $location, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('description: $description, ')
          ..write('lastServiceAt: $lastServiceAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, remoteId, name, type, location,
      serialNumber, description, lastServiceAt, syncedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetsTableData &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.name == this.name &&
          other.type == this.type &&
          other.location == this.location &&
          other.serialNumber == this.serialNumber &&
          other.description == this.description &&
          other.lastServiceAt == this.lastServiceAt &&
          other.syncedAt == this.syncedAt &&
          other.createdAt == this.createdAt);
}

class AssetsTableCompanion extends UpdateCompanion<AssetsTableData> {
  final Value<int> id;
  final Value<String> remoteId;
  final Value<String> name;
  final Value<String> type;
  final Value<String> location;
  final Value<String?> serialNumber;
  final Value<String?> description;
  final Value<DateTime?> lastServiceAt;
  final Value<DateTime?> syncedAt;
  final Value<DateTime> createdAt;
  const AssetsTableCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.location = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.description = const Value.absent(),
    this.lastServiceAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AssetsTableCompanion.insert({
    this.id = const Value.absent(),
    required String remoteId,
    required String name,
    required String type,
    required String location,
    this.serialNumber = const Value.absent(),
    this.description = const Value.absent(),
    this.lastServiceAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : remoteId = Value(remoteId),
        name = Value(name),
        type = Value(type),
        location = Value(location);
  static Insertable<AssetsTableData> custom({
    Expression<int>? id,
    Expression<String>? remoteId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? location,
    Expression<String>? serialNumber,
    Expression<String>? description,
    Expression<DateTime>? lastServiceAt,
    Expression<DateTime>? syncedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (location != null) 'location': location,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (description != null) 'description': description,
      if (lastServiceAt != null) 'last_service_at': lastServiceAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AssetsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? remoteId,
      Value<String>? name,
      Value<String>? type,
      Value<String>? location,
      Value<String?>? serialNumber,
      Value<String?>? description,
      Value<DateTime?>? lastServiceAt,
      Value<DateTime?>? syncedAt,
      Value<DateTime>? createdAt}) {
    return AssetsTableCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
      type: type ?? this.type,
      location: location ?? this.location,
      serialNumber: serialNumber ?? this.serialNumber,
      description: description ?? this.description,
      lastServiceAt: lastServiceAt ?? this.lastServiceAt,
      syncedAt: syncedAt ?? this.syncedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastServiceAt.present) {
      map['last_service_at'] = Variable<DateTime>(lastServiceAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsTableCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('location: $location, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('description: $description, ')
          ..write('lastServiceAt: $lastServiceAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FormTemplatesTableTable extends FormTemplatesTable
    with TableInfo<$FormTemplatesTableTable, FormTemplatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormTemplatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _formIdMeta = const VerificationMeta('formId');
  @override
  late final GeneratedColumn<String> formId = GeneratedColumn<String>(
      'form_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _schemaMeta = const VerificationMeta('schema');
  @override
  late final GeneratedColumn<String> schema = GeneratedColumn<String>(
      'schema', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, formId, version, title, schema, isActive, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'form_templates';
  @override
  VerificationContext validateIntegrity(
      Insertable<FormTemplatesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('form_id')) {
      context.handle(_formIdMeta,
          formId.isAcceptableOrUnknown(data['form_id']!, _formIdMeta));
    } else if (isInserting) {
      context.missing(_formIdMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('schema')) {
      context.handle(_schemaMeta,
          schema.isAcceptableOrUnknown(data['schema']!, _schemaMeta));
    } else if (isInserting) {
      context.missing(_schemaMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormTemplatesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormTemplatesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      formId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form_id'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      schema: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}schema'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $FormTemplatesTableTable createAlias(String alias) {
    return $FormTemplatesTableTable(attachedDatabase, alias);
  }
}

class FormTemplatesTableData extends DataClass
    implements Insertable<FormTemplatesTableData> {
  final int id;
  final String formId;
  final int version;
  final String title;
  final String schema;
  final bool isActive;
  final DateTime cachedAt;
  const FormTemplatesTableData(
      {required this.id,
      required this.formId,
      required this.version,
      required this.title,
      required this.schema,
      required this.isActive,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['form_id'] = Variable<String>(formId);
    map['version'] = Variable<int>(version);
    map['title'] = Variable<String>(title);
    map['schema'] = Variable<String>(schema);
    map['is_active'] = Variable<bool>(isActive);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  FormTemplatesTableCompanion toCompanion(bool nullToAbsent) {
    return FormTemplatesTableCompanion(
      id: Value(id),
      formId: Value(formId),
      version: Value(version),
      title: Value(title),
      schema: Value(schema),
      isActive: Value(isActive),
      cachedAt: Value(cachedAt),
    );
  }

  factory FormTemplatesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormTemplatesTableData(
      id: serializer.fromJson<int>(json['id']),
      formId: serializer.fromJson<String>(json['formId']),
      version: serializer.fromJson<int>(json['version']),
      title: serializer.fromJson<String>(json['title']),
      schema: serializer.fromJson<String>(json['schema']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'formId': serializer.toJson<String>(formId),
      'version': serializer.toJson<int>(version),
      'title': serializer.toJson<String>(title),
      'schema': serializer.toJson<String>(schema),
      'isActive': serializer.toJson<bool>(isActive),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  FormTemplatesTableData copyWith(
          {int? id,
          String? formId,
          int? version,
          String? title,
          String? schema,
          bool? isActive,
          DateTime? cachedAt}) =>
      FormTemplatesTableData(
        id: id ?? this.id,
        formId: formId ?? this.formId,
        version: version ?? this.version,
        title: title ?? this.title,
        schema: schema ?? this.schema,
        isActive: isActive ?? this.isActive,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  FormTemplatesTableData copyWithCompanion(FormTemplatesTableCompanion data) {
    return FormTemplatesTableData(
      id: data.id.present ? data.id.value : this.id,
      formId: data.formId.present ? data.formId.value : this.formId,
      version: data.version.present ? data.version.value : this.version,
      title: data.title.present ? data.title.value : this.title,
      schema: data.schema.present ? data.schema.value : this.schema,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormTemplatesTableData(')
          ..write('id: $id, ')
          ..write('formId: $formId, ')
          ..write('version: $version, ')
          ..write('title: $title, ')
          ..write('schema: $schema, ')
          ..write('isActive: $isActive, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, formId, version, title, schema, isActive, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormTemplatesTableData &&
          other.id == this.id &&
          other.formId == this.formId &&
          other.version == this.version &&
          other.title == this.title &&
          other.schema == this.schema &&
          other.isActive == this.isActive &&
          other.cachedAt == this.cachedAt);
}

class FormTemplatesTableCompanion
    extends UpdateCompanion<FormTemplatesTableData> {
  final Value<int> id;
  final Value<String> formId;
  final Value<int> version;
  final Value<String> title;
  final Value<String> schema;
  final Value<bool> isActive;
  final Value<DateTime> cachedAt;
  const FormTemplatesTableCompanion({
    this.id = const Value.absent(),
    this.formId = const Value.absent(),
    this.version = const Value.absent(),
    this.title = const Value.absent(),
    this.schema = const Value.absent(),
    this.isActive = const Value.absent(),
    this.cachedAt = const Value.absent(),
  });
  FormTemplatesTableCompanion.insert({
    this.id = const Value.absent(),
    required String formId,
    required int version,
    required String title,
    required String schema,
    this.isActive = const Value.absent(),
    this.cachedAt = const Value.absent(),
  })  : formId = Value(formId),
        version = Value(version),
        title = Value(title),
        schema = Value(schema);
  static Insertable<FormTemplatesTableData> custom({
    Expression<int>? id,
    Expression<String>? formId,
    Expression<int>? version,
    Expression<String>? title,
    Expression<String>? schema,
    Expression<bool>? isActive,
    Expression<DateTime>? cachedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (formId != null) 'form_id': formId,
      if (version != null) 'version': version,
      if (title != null) 'title': title,
      if (schema != null) 'schema': schema,
      if (isActive != null) 'is_active': isActive,
      if (cachedAt != null) 'cached_at': cachedAt,
    });
  }

  FormTemplatesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? formId,
      Value<int>? version,
      Value<String>? title,
      Value<String>? schema,
      Value<bool>? isActive,
      Value<DateTime>? cachedAt}) {
    return FormTemplatesTableCompanion(
      id: id ?? this.id,
      formId: formId ?? this.formId,
      version: version ?? this.version,
      title: title ?? this.title,
      schema: schema ?? this.schema,
      isActive: isActive ?? this.isActive,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (formId.present) {
      map['form_id'] = Variable<String>(formId.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (schema.present) {
      map['schema'] = Variable<String>(schema.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormTemplatesTableCompanion(')
          ..write('id: $id, ')
          ..write('formId: $formId, ')
          ..write('version: $version, ')
          ..write('title: $title, ')
          ..write('schema: $schema, ')
          ..write('isActive: $isActive, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }
}

class $InspectionsTableTable extends InspectionsTable
    with TableInfo<$InspectionsTableTable, InspectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _localUuidMeta =
      const VerificationMeta('localUuid');
  @override
  late final GeneratedColumn<String> localUuid = GeneratedColumn<String>(
      'local_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _assetRemoteIdMeta =
      const VerificationMeta('assetRemoteId');
  @override
  late final GeneratedColumn<String> assetRemoteId = GeneratedColumn<String>(
      'asset_remote_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _formIdMeta = const VerificationMeta('formId');
  @override
  late final GeneratedColumn<String> formId = GeneratedColumn<String>(
      'form_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _formVersionMeta =
      const VerificationMeta('formVersion');
  @override
  late final GeneratedColumn<int> formVersion = GeneratedColumn<int>(
      'form_version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _technicianDeviceIdMeta =
      const VerificationMeta('technicianDeviceId');
  @override
  late final GeneratedColumn<String> technicianDeviceId =
      GeneratedColumn<String>('technician_device_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _formDataMeta =
      const VerificationMeta('formData');
  @override
  late final GeneratedColumn<String> formData = GeneratedColumn<String>(
      'form_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('local'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        localUuid,
        remoteId,
        assetRemoteId,
        formId,
        formVersion,
        technicianDeviceId,
        formData,
        syncStatus,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspections';
  @override
  VerificationContext validateIntegrity(
      Insertable<InspectionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_uuid')) {
      context.handle(_localUuidMeta,
          localUuid.isAcceptableOrUnknown(data['local_uuid']!, _localUuidMeta));
    } else if (isInserting) {
      context.missing(_localUuidMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('asset_remote_id')) {
      context.handle(
          _assetRemoteIdMeta,
          assetRemoteId.isAcceptableOrUnknown(
              data['asset_remote_id']!, _assetRemoteIdMeta));
    } else if (isInserting) {
      context.missing(_assetRemoteIdMeta);
    }
    if (data.containsKey('form_id')) {
      context.handle(_formIdMeta,
          formId.isAcceptableOrUnknown(data['form_id']!, _formIdMeta));
    } else if (isInserting) {
      context.missing(_formIdMeta);
    }
    if (data.containsKey('form_version')) {
      context.handle(
          _formVersionMeta,
          formVersion.isAcceptableOrUnknown(
              data['form_version']!, _formVersionMeta));
    } else if (isInserting) {
      context.missing(_formVersionMeta);
    }
    if (data.containsKey('technician_device_id')) {
      context.handle(
          _technicianDeviceIdMeta,
          technicianDeviceId.isAcceptableOrUnknown(
              data['technician_device_id']!, _technicianDeviceIdMeta));
    } else if (isInserting) {
      context.missing(_technicianDeviceIdMeta);
    }
    if (data.containsKey('form_data')) {
      context.handle(_formDataMeta,
          formData.isAcceptableOrUnknown(data['form_data']!, _formDataMeta));
    } else if (isInserting) {
      context.missing(_formDataMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspectionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      localUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_uuid'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      assetRemoteId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}asset_remote_id'])!,
      formId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form_id'])!,
      formVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}form_version'])!,
      technicianDeviceId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}technician_device_id'])!,
      formData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form_data'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $InspectionsTableTable createAlias(String alias) {
    return $InspectionsTableTable(attachedDatabase, alias);
  }
}

class InspectionsTableData extends DataClass
    implements Insertable<InspectionsTableData> {
  final int id;
  final String localUuid;
  final String? remoteId;
  final String assetRemoteId;
  final String formId;
  final int formVersion;
  final String technicianDeviceId;
  final String formData;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InspectionsTableData(
      {required this.id,
      required this.localUuid,
      this.remoteId,
      required this.assetRemoteId,
      required this.formId,
      required this.formVersion,
      required this.technicianDeviceId,
      required this.formData,
      required this.syncStatus,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_uuid'] = Variable<String>(localUuid);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['asset_remote_id'] = Variable<String>(assetRemoteId);
    map['form_id'] = Variable<String>(formId);
    map['form_version'] = Variable<int>(formVersion);
    map['technician_device_id'] = Variable<String>(technicianDeviceId);
    map['form_data'] = Variable<String>(formData);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InspectionsTableCompanion toCompanion(bool nullToAbsent) {
    return InspectionsTableCompanion(
      id: Value(id),
      localUuid: Value(localUuid),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      assetRemoteId: Value(assetRemoteId),
      formId: Value(formId),
      formVersion: Value(formVersion),
      technicianDeviceId: Value(technicianDeviceId),
      formData: Value(formData),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InspectionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionsTableData(
      id: serializer.fromJson<int>(json['id']),
      localUuid: serializer.fromJson<String>(json['localUuid']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      assetRemoteId: serializer.fromJson<String>(json['assetRemoteId']),
      formId: serializer.fromJson<String>(json['formId']),
      formVersion: serializer.fromJson<int>(json['formVersion']),
      technicianDeviceId:
          serializer.fromJson<String>(json['technicianDeviceId']),
      formData: serializer.fromJson<String>(json['formData']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUuid': serializer.toJson<String>(localUuid),
      'remoteId': serializer.toJson<String?>(remoteId),
      'assetRemoteId': serializer.toJson<String>(assetRemoteId),
      'formId': serializer.toJson<String>(formId),
      'formVersion': serializer.toJson<int>(formVersion),
      'technicianDeviceId': serializer.toJson<String>(technicianDeviceId),
      'formData': serializer.toJson<String>(formData),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InspectionsTableData copyWith(
          {int? id,
          String? localUuid,
          Value<String?> remoteId = const Value.absent(),
          String? assetRemoteId,
          String? formId,
          int? formVersion,
          String? technicianDeviceId,
          String? formData,
          String? syncStatus,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      InspectionsTableData(
        id: id ?? this.id,
        localUuid: localUuid ?? this.localUuid,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        assetRemoteId: assetRemoteId ?? this.assetRemoteId,
        formId: formId ?? this.formId,
        formVersion: formVersion ?? this.formVersion,
        technicianDeviceId: technicianDeviceId ?? this.technicianDeviceId,
        formData: formData ?? this.formData,
        syncStatus: syncStatus ?? this.syncStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  InspectionsTableData copyWithCompanion(InspectionsTableCompanion data) {
    return InspectionsTableData(
      id: data.id.present ? data.id.value : this.id,
      localUuid: data.localUuid.present ? data.localUuid.value : this.localUuid,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      assetRemoteId: data.assetRemoteId.present
          ? data.assetRemoteId.value
          : this.assetRemoteId,
      formId: data.formId.present ? data.formId.value : this.formId,
      formVersion:
          data.formVersion.present ? data.formVersion.value : this.formVersion,
      technicianDeviceId: data.technicianDeviceId.present
          ? data.technicianDeviceId.value
          : this.technicianDeviceId,
      formData: data.formData.present ? data.formData.value : this.formData,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsTableData(')
          ..write('id: $id, ')
          ..write('localUuid: $localUuid, ')
          ..write('remoteId: $remoteId, ')
          ..write('assetRemoteId: $assetRemoteId, ')
          ..write('formId: $formId, ')
          ..write('formVersion: $formVersion, ')
          ..write('technicianDeviceId: $technicianDeviceId, ')
          ..write('formData: $formData, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      localUuid,
      remoteId,
      assetRemoteId,
      formId,
      formVersion,
      technicianDeviceId,
      formData,
      syncStatus,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionsTableData &&
          other.id == this.id &&
          other.localUuid == this.localUuid &&
          other.remoteId == this.remoteId &&
          other.assetRemoteId == this.assetRemoteId &&
          other.formId == this.formId &&
          other.formVersion == this.formVersion &&
          other.technicianDeviceId == this.technicianDeviceId &&
          other.formData == this.formData &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InspectionsTableCompanion extends UpdateCompanion<InspectionsTableData> {
  final Value<int> id;
  final Value<String> localUuid;
  final Value<String?> remoteId;
  final Value<String> assetRemoteId;
  final Value<String> formId;
  final Value<int> formVersion;
  final Value<String> technicianDeviceId;
  final Value<String> formData;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InspectionsTableCompanion({
    this.id = const Value.absent(),
    this.localUuid = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.assetRemoteId = const Value.absent(),
    this.formId = const Value.absent(),
    this.formVersion = const Value.absent(),
    this.technicianDeviceId = const Value.absent(),
    this.formData = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InspectionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String localUuid,
    this.remoteId = const Value.absent(),
    required String assetRemoteId,
    required String formId,
    required int formVersion,
    required String technicianDeviceId,
    required String formData,
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : localUuid = Value(localUuid),
        assetRemoteId = Value(assetRemoteId),
        formId = Value(formId),
        formVersion = Value(formVersion),
        technicianDeviceId = Value(technicianDeviceId),
        formData = Value(formData);
  static Insertable<InspectionsTableData> custom({
    Expression<int>? id,
    Expression<String>? localUuid,
    Expression<String>? remoteId,
    Expression<String>? assetRemoteId,
    Expression<String>? formId,
    Expression<int>? formVersion,
    Expression<String>? technicianDeviceId,
    Expression<String>? formData,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUuid != null) 'local_uuid': localUuid,
      if (remoteId != null) 'remote_id': remoteId,
      if (assetRemoteId != null) 'asset_remote_id': assetRemoteId,
      if (formId != null) 'form_id': formId,
      if (formVersion != null) 'form_version': formVersion,
      if (technicianDeviceId != null)
        'technician_device_id': technicianDeviceId,
      if (formData != null) 'form_data': formData,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InspectionsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? localUuid,
      Value<String?>? remoteId,
      Value<String>? assetRemoteId,
      Value<String>? formId,
      Value<int>? formVersion,
      Value<String>? technicianDeviceId,
      Value<String>? formData,
      Value<String>? syncStatus,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return InspectionsTableCompanion(
      id: id ?? this.id,
      localUuid: localUuid ?? this.localUuid,
      remoteId: remoteId ?? this.remoteId,
      assetRemoteId: assetRemoteId ?? this.assetRemoteId,
      formId: formId ?? this.formId,
      formVersion: formVersion ?? this.formVersion,
      technicianDeviceId: technicianDeviceId ?? this.technicianDeviceId,
      formData: formData ?? this.formData,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUuid.present) {
      map['local_uuid'] = Variable<String>(localUuid.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (assetRemoteId.present) {
      map['asset_remote_id'] = Variable<String>(assetRemoteId.value);
    }
    if (formId.present) {
      map['form_id'] = Variable<String>(formId.value);
    }
    if (formVersion.present) {
      map['form_version'] = Variable<int>(formVersion.value);
    }
    if (technicianDeviceId.present) {
      map['technician_device_id'] = Variable<String>(technicianDeviceId.value);
    }
    if (formData.present) {
      map['form_data'] = Variable<String>(formData.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('localUuid: $localUuid, ')
          ..write('remoteId: $remoteId, ')
          ..write('assetRemoteId: $assetRemoteId, ')
          ..write('formId: $formId, ')
          ..write('formVersion: $formVersion, ')
          ..write('technicianDeviceId: $technicianDeviceId, ')
          ..write('formData: $formData, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $OutboxTableTable extends OutboxTable
    with TableInfo<$OutboxTableTable, OutboxTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entityType,
        entityId,
        operation,
        payload,
        deviceId,
        attempts,
        status,
        lastAttemptAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_queue';
  @override
  VerificationContext validateIntegrity(Insertable<OutboxTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $OutboxTableTable createAlias(String alias) {
    return $OutboxTableTable(attachedDatabase, alias);
  }
}

class OutboxTableData extends DataClass implements Insertable<OutboxTableData> {
  final int id;
  final String entityType;
  final String entityId;
  final String operation;
  final String payload;
  final String deviceId;
  final int attempts;
  final String status;
  final DateTime? lastAttemptAt;
  final DateTime createdAt;
  const OutboxTableData(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.payload,
      required this.deviceId,
      required this.attempts,
      required this.status,
      this.lastAttemptAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['device_id'] = Variable<String>(deviceId);
    map['attempts'] = Variable<int>(attempts);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OutboxTableCompanion toCompanion(bool nullToAbsent) {
    return OutboxTableCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: Value(payload),
      deviceId: Value(deviceId),
      attempts: Value(attempts),
      status: Value(status),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      createdAt: Value(createdAt),
    );
  }

  factory OutboxTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxTableData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      attempts: serializer.fromJson<int>(json['attempts']),
      status: serializer.fromJson<String>(json['status']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'deviceId': serializer.toJson<String>(deviceId),
      'attempts': serializer.toJson<int>(attempts),
      'status': serializer.toJson<String>(status),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OutboxTableData copyWith(
          {int? id,
          String? entityType,
          String? entityId,
          String? operation,
          String? payload,
          String? deviceId,
          int? attempts,
          String? status,
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          DateTime? createdAt}) =>
      OutboxTableData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        deviceId: deviceId ?? this.deviceId,
        attempts: attempts ?? this.attempts,
        status: status ?? this.status,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
        createdAt: createdAt ?? this.createdAt,
      );
  OutboxTableData copyWithCompanion(OutboxTableCompanion data) {
    return OutboxTableData(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      status: data.status.present ? data.status.value : this.status,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxTableData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('deviceId: $deviceId, ')
          ..write('attempts: $attempts, ')
          ..write('status: $status, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, entityId, operation, payload,
      deviceId, attempts, status, lastAttemptAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxTableData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.deviceId == this.deviceId &&
          other.attempts == this.attempts &&
          other.status == this.status &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.createdAt == this.createdAt);
}

class OutboxTableCompanion extends UpdateCompanion<OutboxTableData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<String> deviceId;
  final Value<int> attempts;
  final Value<String> status;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime> createdAt;
  const OutboxTableCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.attempts = const Value.absent(),
    this.status = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OutboxTableCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String operation,
    required String payload,
    required String deviceId,
    this.attempts = const Value.absent(),
    this.status = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : entityType = Value(entityType),
        entityId = Value(entityId),
        operation = Value(operation),
        payload = Value(payload),
        deviceId = Value(deviceId);
  static Insertable<OutboxTableData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<String>? deviceId,
    Expression<int>? attempts,
    Expression<String>? status,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (deviceId != null) 'device_id': deviceId,
      if (attempts != null) 'attempts': attempts,
      if (status != null) 'status': status,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OutboxTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? operation,
      Value<String>? payload,
      Value<String>? deviceId,
      Value<int>? attempts,
      Value<String>? status,
      Value<DateTime?>? lastAttemptAt,
      Value<DateTime>? createdAt}) {
    return OutboxTableCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      deviceId: deviceId ?? this.deviceId,
      attempts: attempts ?? this.attempts,
      status: status ?? this.status,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxTableCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('deviceId: $deviceId, ')
          ..write('attempts: $attempts, ')
          ..write('status: $status, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MediaFilesTableTable extends MediaFilesTable
    with TableInfo<$MediaFilesTableTable, MediaFilesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaFilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _inspectionUuidMeta =
      const VerificationMeta('inspectionUuid');
  @override
  late final GeneratedColumn<String> inspectionUuid = GeneratedColumn<String>(
      'inspection_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fieldIdMeta =
      const VerificationMeta('fieldId');
  @override
  late final GeneratedColumn<String> fieldId = GeneratedColumn<String>(
      'field_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _compressedPathMeta =
      const VerificationMeta('compressedPath');
  @override
  late final GeneratedColumn<String> compressedPath = GeneratedColumn<String>(
      'compressed_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _remoteUrlMeta =
      const VerificationMeta('remoteUrl');
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
      'remote_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isUploadedMeta =
      const VerificationMeta('isUploaded');
  @override
  late final GeneratedColumn<bool> isUploaded = GeneratedColumn<bool>(
      'is_uploaded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_uploaded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _fileSizeBytesMeta =
      const VerificationMeta('fileSizeBytes');
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
      'file_size_bytes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        inspectionUuid,
        fieldId,
        localPath,
        compressedPath,
        remoteUrl,
        isUploaded,
        fileSizeBytes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_files';
  @override
  VerificationContext validateIntegrity(
      Insertable<MediaFilesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('inspection_uuid')) {
      context.handle(
          _inspectionUuidMeta,
          inspectionUuid.isAcceptableOrUnknown(
              data['inspection_uuid']!, _inspectionUuidMeta));
    } else if (isInserting) {
      context.missing(_inspectionUuidMeta);
    }
    if (data.containsKey('field_id')) {
      context.handle(_fieldIdMeta,
          fieldId.isAcceptableOrUnknown(data['field_id']!, _fieldIdMeta));
    } else if (isInserting) {
      context.missing(_fieldIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('compressed_path')) {
      context.handle(
          _compressedPathMeta,
          compressedPath.isAcceptableOrUnknown(
              data['compressed_path']!, _compressedPathMeta));
    }
    if (data.containsKey('remote_url')) {
      context.handle(_remoteUrlMeta,
          remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta));
    }
    if (data.containsKey('is_uploaded')) {
      context.handle(
          _isUploadedMeta,
          isUploaded.isAcceptableOrUnknown(
              data['is_uploaded']!, _isUploadedMeta));
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
          _fileSizeBytesMeta,
          fileSizeBytes.isAcceptableOrUnknown(
              data['file_size_bytes']!, _fileSizeBytesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaFilesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaFilesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      inspectionUuid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}inspection_uuid'])!,
      fieldId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_id'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path'])!,
      compressedPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}compressed_path']),
      remoteUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_url']),
      isUploaded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_uploaded'])!,
      fileSizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size_bytes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MediaFilesTableTable createAlias(String alias) {
    return $MediaFilesTableTable(attachedDatabase, alias);
  }
}

class MediaFilesTableData extends DataClass
    implements Insertable<MediaFilesTableData> {
  final int id;
  final String inspectionUuid;
  final String fieldId;
  final String localPath;
  final String? compressedPath;
  final String? remoteUrl;
  final bool isUploaded;
  final int? fileSizeBytes;
  final DateTime createdAt;
  const MediaFilesTableData(
      {required this.id,
      required this.inspectionUuid,
      required this.fieldId,
      required this.localPath,
      this.compressedPath,
      this.remoteUrl,
      required this.isUploaded,
      this.fileSizeBytes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['inspection_uuid'] = Variable<String>(inspectionUuid);
    map['field_id'] = Variable<String>(fieldId);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || compressedPath != null) {
      map['compressed_path'] = Variable<String>(compressedPath);
    }
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    map['is_uploaded'] = Variable<bool>(isUploaded);
    if (!nullToAbsent || fileSizeBytes != null) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MediaFilesTableCompanion toCompanion(bool nullToAbsent) {
    return MediaFilesTableCompanion(
      id: Value(id),
      inspectionUuid: Value(inspectionUuid),
      fieldId: Value(fieldId),
      localPath: Value(localPath),
      compressedPath: compressedPath == null && nullToAbsent
          ? const Value.absent()
          : Value(compressedPath),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      isUploaded: Value(isUploaded),
      fileSizeBytes: fileSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSizeBytes),
      createdAt: Value(createdAt),
    );
  }

  factory MediaFilesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaFilesTableData(
      id: serializer.fromJson<int>(json['id']),
      inspectionUuid: serializer.fromJson<String>(json['inspectionUuid']),
      fieldId: serializer.fromJson<String>(json['fieldId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      compressedPath: serializer.fromJson<String?>(json['compressedPath']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      isUploaded: serializer.fromJson<bool>(json['isUploaded']),
      fileSizeBytes: serializer.fromJson<int?>(json['fileSizeBytes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inspectionUuid': serializer.toJson<String>(inspectionUuid),
      'fieldId': serializer.toJson<String>(fieldId),
      'localPath': serializer.toJson<String>(localPath),
      'compressedPath': serializer.toJson<String?>(compressedPath),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'isUploaded': serializer.toJson<bool>(isUploaded),
      'fileSizeBytes': serializer.toJson<int?>(fileSizeBytes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MediaFilesTableData copyWith(
          {int? id,
          String? inspectionUuid,
          String? fieldId,
          String? localPath,
          Value<String?> compressedPath = const Value.absent(),
          Value<String?> remoteUrl = const Value.absent(),
          bool? isUploaded,
          Value<int?> fileSizeBytes = const Value.absent(),
          DateTime? createdAt}) =>
      MediaFilesTableData(
        id: id ?? this.id,
        inspectionUuid: inspectionUuid ?? this.inspectionUuid,
        fieldId: fieldId ?? this.fieldId,
        localPath: localPath ?? this.localPath,
        compressedPath:
            compressedPath.present ? compressedPath.value : this.compressedPath,
        remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
        isUploaded: isUploaded ?? this.isUploaded,
        fileSizeBytes:
            fileSizeBytes.present ? fileSizeBytes.value : this.fileSizeBytes,
        createdAt: createdAt ?? this.createdAt,
      );
  MediaFilesTableData copyWithCompanion(MediaFilesTableCompanion data) {
    return MediaFilesTableData(
      id: data.id.present ? data.id.value : this.id,
      inspectionUuid: data.inspectionUuid.present
          ? data.inspectionUuid.value
          : this.inspectionUuid,
      fieldId: data.fieldId.present ? data.fieldId.value : this.fieldId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      compressedPath: data.compressedPath.present
          ? data.compressedPath.value
          : this.compressedPath,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      isUploaded:
          data.isUploaded.present ? data.isUploaded.value : this.isUploaded,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaFilesTableData(')
          ..write('id: $id, ')
          ..write('inspectionUuid: $inspectionUuid, ')
          ..write('fieldId: $fieldId, ')
          ..write('localPath: $localPath, ')
          ..write('compressedPath: $compressedPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('isUploaded: $isUploaded, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, inspectionUuid, fieldId, localPath,
      compressedPath, remoteUrl, isUploaded, fileSizeBytes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaFilesTableData &&
          other.id == this.id &&
          other.inspectionUuid == this.inspectionUuid &&
          other.fieldId == this.fieldId &&
          other.localPath == this.localPath &&
          other.compressedPath == this.compressedPath &&
          other.remoteUrl == this.remoteUrl &&
          other.isUploaded == this.isUploaded &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.createdAt == this.createdAt);
}

class MediaFilesTableCompanion extends UpdateCompanion<MediaFilesTableData> {
  final Value<int> id;
  final Value<String> inspectionUuid;
  final Value<String> fieldId;
  final Value<String> localPath;
  final Value<String?> compressedPath;
  final Value<String?> remoteUrl;
  final Value<bool> isUploaded;
  final Value<int?> fileSizeBytes;
  final Value<DateTime> createdAt;
  const MediaFilesTableCompanion({
    this.id = const Value.absent(),
    this.inspectionUuid = const Value.absent(),
    this.fieldId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.compressedPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.isUploaded = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MediaFilesTableCompanion.insert({
    this.id = const Value.absent(),
    required String inspectionUuid,
    required String fieldId,
    required String localPath,
    this.compressedPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.isUploaded = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : inspectionUuid = Value(inspectionUuid),
        fieldId = Value(fieldId),
        localPath = Value(localPath);
  static Insertable<MediaFilesTableData> custom({
    Expression<int>? id,
    Expression<String>? inspectionUuid,
    Expression<String>? fieldId,
    Expression<String>? localPath,
    Expression<String>? compressedPath,
    Expression<String>? remoteUrl,
    Expression<bool>? isUploaded,
    Expression<int>? fileSizeBytes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inspectionUuid != null) 'inspection_uuid': inspectionUuid,
      if (fieldId != null) 'field_id': fieldId,
      if (localPath != null) 'local_path': localPath,
      if (compressedPath != null) 'compressed_path': compressedPath,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (isUploaded != null) 'is_uploaded': isUploaded,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MediaFilesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? inspectionUuid,
      Value<String>? fieldId,
      Value<String>? localPath,
      Value<String?>? compressedPath,
      Value<String?>? remoteUrl,
      Value<bool>? isUploaded,
      Value<int?>? fileSizeBytes,
      Value<DateTime>? createdAt}) {
    return MediaFilesTableCompanion(
      id: id ?? this.id,
      inspectionUuid: inspectionUuid ?? this.inspectionUuid,
      fieldId: fieldId ?? this.fieldId,
      localPath: localPath ?? this.localPath,
      compressedPath: compressedPath ?? this.compressedPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      isUploaded: isUploaded ?? this.isUploaded,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inspectionUuid.present) {
      map['inspection_uuid'] = Variable<String>(inspectionUuid.value);
    }
    if (fieldId.present) {
      map['field_id'] = Variable<String>(fieldId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (compressedPath.present) {
      map['compressed_path'] = Variable<String>(compressedPath.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (isUploaded.present) {
      map['is_uploaded'] = Variable<bool>(isUploaded.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaFilesTableCompanion(')
          ..write('id: $id, ')
          ..write('inspectionUuid: $inspectionUuid, ')
          ..write('fieldId: $fieldId, ')
          ..write('localPath: $localPath, ')
          ..write('compressedPath: $compressedPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('isUploaded: $isUploaded, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $AssetsTableTable assetsTable = $AssetsTableTable(this);
  late final $FormTemplatesTableTable formTemplatesTable =
      $FormTemplatesTableTable(this);
  late final $InspectionsTableTable inspectionsTable =
      $InspectionsTableTable(this);
  late final $OutboxTableTable outboxTable = $OutboxTableTable(this);
  late final $MediaFilesTableTable mediaFilesTable =
      $MediaFilesTableTable(this);
  late final AssetsDao assetsDao = AssetsDao(this as AppDatabase);
  late final InspectionsDao inspectionsDao =
      InspectionsDao(this as AppDatabase);
  late final OutboxDao outboxDao = OutboxDao(this as AppDatabase);
  late final FormTemplatesDao formTemplatesDao =
      FormTemplatesDao(this as AppDatabase);
  late final MediaDao mediaDao = MediaDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        usersTable,
        assetsTable,
        formTemplatesTable,
        inspectionsTable,
        outboxTable,
        mediaFilesTable
      ];
}

typedef $$UsersTableTableCreateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  required String remoteId,
  required String name,
  required String email,
  required String role,
  required String deviceId,
  Value<DateTime> createdAt,
});
typedef $$UsersTableTableUpdateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  Value<String> remoteId,
  Value<String> name,
  Value<String> email,
  Value<String> role,
  Value<String> deviceId,
  Value<DateTime> createdAt,
});

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (
      UsersTableData,
      BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>
    ),
    UsersTableData,
    PrefetchHooks Function()> {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> remoteId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> deviceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersTableCompanion(
            id: id,
            remoteId: remoteId,
            name: name,
            email: email,
            role: role,
            deviceId: deviceId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String remoteId,
            required String name,
            required String email,
            required String role,
            required String deviceId,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersTableCompanion.insert(
            id: id,
            remoteId: remoteId,
            name: name,
            email: email,
            role: role,
            deviceId: deviceId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (
      UsersTableData,
      BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>
    ),
    UsersTableData,
    PrefetchHooks Function()>;
typedef $$AssetsTableTableCreateCompanionBuilder = AssetsTableCompanion
    Function({
  Value<int> id,
  required String remoteId,
  required String name,
  required String type,
  required String location,
  Value<String?> serialNumber,
  Value<String?> description,
  Value<DateTime?> lastServiceAt,
  Value<DateTime?> syncedAt,
  Value<DateTime> createdAt,
});
typedef $$AssetsTableTableUpdateCompanionBuilder = AssetsTableCompanion
    Function({
  Value<int> id,
  Value<String> remoteId,
  Value<String> name,
  Value<String> type,
  Value<String> location,
  Value<String?> serialNumber,
  Value<String?> description,
  Value<DateTime?> lastServiceAt,
  Value<DateTime?> syncedAt,
  Value<DateTime> createdAt,
});

class $$AssetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTableTable> {
  $$AssetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastServiceAt => $composableBuilder(
      column: $table.lastServiceAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AssetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTableTable> {
  $$AssetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastServiceAt => $composableBuilder(
      column: $table.lastServiceAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AssetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTableTable> {
  $$AssetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get lastServiceAt => $composableBuilder(
      column: $table.lastServiceAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AssetsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssetsTableTable,
    AssetsTableData,
    $$AssetsTableTableFilterComposer,
    $$AssetsTableTableOrderingComposer,
    $$AssetsTableTableAnnotationComposer,
    $$AssetsTableTableCreateCompanionBuilder,
    $$AssetsTableTableUpdateCompanionBuilder,
    (
      AssetsTableData,
      BaseReferences<_$AppDatabase, $AssetsTableTable, AssetsTableData>
    ),
    AssetsTableData,
    PrefetchHooks Function()> {
  $$AssetsTableTableTableManager(_$AppDatabase db, $AssetsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> remoteId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String?> serialNumber = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> lastServiceAt = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AssetsTableCompanion(
            id: id,
            remoteId: remoteId,
            name: name,
            type: type,
            location: location,
            serialNumber: serialNumber,
            description: description,
            lastServiceAt: lastServiceAt,
            syncedAt: syncedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String remoteId,
            required String name,
            required String type,
            required String location,
            Value<String?> serialNumber = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> lastServiceAt = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AssetsTableCompanion.insert(
            id: id,
            remoteId: remoteId,
            name: name,
            type: type,
            location: location,
            serialNumber: serialNumber,
            description: description,
            lastServiceAt: lastServiceAt,
            syncedAt: syncedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AssetsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssetsTableTable,
    AssetsTableData,
    $$AssetsTableTableFilterComposer,
    $$AssetsTableTableOrderingComposer,
    $$AssetsTableTableAnnotationComposer,
    $$AssetsTableTableCreateCompanionBuilder,
    $$AssetsTableTableUpdateCompanionBuilder,
    (
      AssetsTableData,
      BaseReferences<_$AppDatabase, $AssetsTableTable, AssetsTableData>
    ),
    AssetsTableData,
    PrefetchHooks Function()>;
typedef $$FormTemplatesTableTableCreateCompanionBuilder
    = FormTemplatesTableCompanion Function({
  Value<int> id,
  required String formId,
  required int version,
  required String title,
  required String schema,
  Value<bool> isActive,
  Value<DateTime> cachedAt,
});
typedef $$FormTemplatesTableTableUpdateCompanionBuilder
    = FormTemplatesTableCompanion Function({
  Value<int> id,
  Value<String> formId,
  Value<int> version,
  Value<String> title,
  Value<String> schema,
  Value<bool> isActive,
  Value<DateTime> cachedAt,
});

class $$FormTemplatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FormTemplatesTableTable> {
  $$FormTemplatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formId => $composableBuilder(
      column: $table.formId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get schema => $composableBuilder(
      column: $table.schema, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$FormTemplatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FormTemplatesTableTable> {
  $$FormTemplatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formId => $composableBuilder(
      column: $table.formId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get schema => $composableBuilder(
      column: $table.schema, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$FormTemplatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormTemplatesTableTable> {
  $$FormTemplatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get formId =>
      $composableBuilder(column: $table.formId, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get schema =>
      $composableBuilder(column: $table.schema, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$FormTemplatesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FormTemplatesTableTable,
    FormTemplatesTableData,
    $$FormTemplatesTableTableFilterComposer,
    $$FormTemplatesTableTableOrderingComposer,
    $$FormTemplatesTableTableAnnotationComposer,
    $$FormTemplatesTableTableCreateCompanionBuilder,
    $$FormTemplatesTableTableUpdateCompanionBuilder,
    (
      FormTemplatesTableData,
      BaseReferences<_$AppDatabase, $FormTemplatesTableTable,
          FormTemplatesTableData>
    ),
    FormTemplatesTableData,
    PrefetchHooks Function()> {
  $$FormTemplatesTableTableTableManager(
      _$AppDatabase db, $FormTemplatesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormTemplatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormTemplatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormTemplatesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> formId = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> schema = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
          }) =>
              FormTemplatesTableCompanion(
            id: id,
            formId: formId,
            version: version,
            title: title,
            schema: schema,
            isActive: isActive,
            cachedAt: cachedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String formId,
            required int version,
            required String title,
            required String schema,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
          }) =>
              FormTemplatesTableCompanion.insert(
            id: id,
            formId: formId,
            version: version,
            title: title,
            schema: schema,
            isActive: isActive,
            cachedAt: cachedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FormTemplatesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FormTemplatesTableTable,
    FormTemplatesTableData,
    $$FormTemplatesTableTableFilterComposer,
    $$FormTemplatesTableTableOrderingComposer,
    $$FormTemplatesTableTableAnnotationComposer,
    $$FormTemplatesTableTableCreateCompanionBuilder,
    $$FormTemplatesTableTableUpdateCompanionBuilder,
    (
      FormTemplatesTableData,
      BaseReferences<_$AppDatabase, $FormTemplatesTableTable,
          FormTemplatesTableData>
    ),
    FormTemplatesTableData,
    PrefetchHooks Function()>;
typedef $$InspectionsTableTableCreateCompanionBuilder
    = InspectionsTableCompanion Function({
  Value<int> id,
  required String localUuid,
  Value<String?> remoteId,
  required String assetRemoteId,
  required String formId,
  required int formVersion,
  required String technicianDeviceId,
  required String formData,
  Value<String> syncStatus,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$InspectionsTableTableUpdateCompanionBuilder
    = InspectionsTableCompanion Function({
  Value<int> id,
  Value<String> localUuid,
  Value<String?> remoteId,
  Value<String> assetRemoteId,
  Value<String> formId,
  Value<int> formVersion,
  Value<String> technicianDeviceId,
  Value<String> formData,
  Value<String> syncStatus,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$InspectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localUuid => $composableBuilder(
      column: $table.localUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assetRemoteId => $composableBuilder(
      column: $table.assetRemoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formId => $composableBuilder(
      column: $table.formId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get formVersion => $composableBuilder(
      column: $table.formVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get technicianDeviceId => $composableBuilder(
      column: $table.technicianDeviceId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formData => $composableBuilder(
      column: $table.formData, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$InspectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localUuid => $composableBuilder(
      column: $table.localUuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assetRemoteId => $composableBuilder(
      column: $table.assetRemoteId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formId => $composableBuilder(
      column: $table.formId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get formVersion => $composableBuilder(
      column: $table.formVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get technicianDeviceId => $composableBuilder(
      column: $table.technicianDeviceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formData => $composableBuilder(
      column: $table.formData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$InspectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localUuid =>
      $composableBuilder(column: $table.localUuid, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get assetRemoteId => $composableBuilder(
      column: $table.assetRemoteId, builder: (column) => column);

  GeneratedColumn<String> get formId =>
      $composableBuilder(column: $table.formId, builder: (column) => column);

  GeneratedColumn<int> get formVersion => $composableBuilder(
      column: $table.formVersion, builder: (column) => column);

  GeneratedColumn<String> get technicianDeviceId => $composableBuilder(
      column: $table.technicianDeviceId, builder: (column) => column);

  GeneratedColumn<String> get formData =>
      $composableBuilder(column: $table.formData, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InspectionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InspectionsTableTable,
    InspectionsTableData,
    $$InspectionsTableTableFilterComposer,
    $$InspectionsTableTableOrderingComposer,
    $$InspectionsTableTableAnnotationComposer,
    $$InspectionsTableTableCreateCompanionBuilder,
    $$InspectionsTableTableUpdateCompanionBuilder,
    (
      InspectionsTableData,
      BaseReferences<_$AppDatabase, $InspectionsTableTable,
          InspectionsTableData>
    ),
    InspectionsTableData,
    PrefetchHooks Function()> {
  $$InspectionsTableTableTableManager(
      _$AppDatabase db, $InspectionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> localUuid = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> assetRemoteId = const Value.absent(),
            Value<String> formId = const Value.absent(),
            Value<int> formVersion = const Value.absent(),
            Value<String> technicianDeviceId = const Value.absent(),
            Value<String> formData = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              InspectionsTableCompanion(
            id: id,
            localUuid: localUuid,
            remoteId: remoteId,
            assetRemoteId: assetRemoteId,
            formId: formId,
            formVersion: formVersion,
            technicianDeviceId: technicianDeviceId,
            formData: formData,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String localUuid,
            Value<String?> remoteId = const Value.absent(),
            required String assetRemoteId,
            required String formId,
            required int formVersion,
            required String technicianDeviceId,
            required String formData,
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              InspectionsTableCompanion.insert(
            id: id,
            localUuid: localUuid,
            remoteId: remoteId,
            assetRemoteId: assetRemoteId,
            formId: formId,
            formVersion: formVersion,
            technicianDeviceId: technicianDeviceId,
            formData: formData,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InspectionsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InspectionsTableTable,
    InspectionsTableData,
    $$InspectionsTableTableFilterComposer,
    $$InspectionsTableTableOrderingComposer,
    $$InspectionsTableTableAnnotationComposer,
    $$InspectionsTableTableCreateCompanionBuilder,
    $$InspectionsTableTableUpdateCompanionBuilder,
    (
      InspectionsTableData,
      BaseReferences<_$AppDatabase, $InspectionsTableTable,
          InspectionsTableData>
    ),
    InspectionsTableData,
    PrefetchHooks Function()>;
typedef $$OutboxTableTableCreateCompanionBuilder = OutboxTableCompanion
    Function({
  Value<int> id,
  required String entityType,
  required String entityId,
  required String operation,
  required String payload,
  required String deviceId,
  Value<int> attempts,
  Value<String> status,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime> createdAt,
});
typedef $$OutboxTableTableUpdateCompanionBuilder = OutboxTableCompanion
    Function({
  Value<int> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> operation,
  Value<String> payload,
  Value<String> deviceId,
  Value<int> attempts,
  Value<String> status,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime> createdAt,
});

class $$OutboxTableTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxTableTable> {
  $$OutboxTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$OutboxTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxTableTable> {
  $$OutboxTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$OutboxTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxTableTable> {
  $$OutboxTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OutboxTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OutboxTableTable,
    OutboxTableData,
    $$OutboxTableTableFilterComposer,
    $$OutboxTableTableOrderingComposer,
    $$OutboxTableTableAnnotationComposer,
    $$OutboxTableTableCreateCompanionBuilder,
    $$OutboxTableTableUpdateCompanionBuilder,
    (
      OutboxTableData,
      BaseReferences<_$AppDatabase, $OutboxTableTable, OutboxTableData>
    ),
    OutboxTableData,
    PrefetchHooks Function()> {
  $$OutboxTableTableTableManager(_$AppDatabase db, $OutboxTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<String> deviceId = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              OutboxTableCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            deviceId: deviceId,
            attempts: attempts,
            status: status,
            lastAttemptAt: lastAttemptAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required String entityId,
            required String operation,
            required String payload,
            required String deviceId,
            Value<int> attempts = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              OutboxTableCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            deviceId: deviceId,
            attempts: attempts,
            status: status,
            lastAttemptAt: lastAttemptAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OutboxTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OutboxTableTable,
    OutboxTableData,
    $$OutboxTableTableFilterComposer,
    $$OutboxTableTableOrderingComposer,
    $$OutboxTableTableAnnotationComposer,
    $$OutboxTableTableCreateCompanionBuilder,
    $$OutboxTableTableUpdateCompanionBuilder,
    (
      OutboxTableData,
      BaseReferences<_$AppDatabase, $OutboxTableTable, OutboxTableData>
    ),
    OutboxTableData,
    PrefetchHooks Function()>;
typedef $$MediaFilesTableTableCreateCompanionBuilder = MediaFilesTableCompanion
    Function({
  Value<int> id,
  required String inspectionUuid,
  required String fieldId,
  required String localPath,
  Value<String?> compressedPath,
  Value<String?> remoteUrl,
  Value<bool> isUploaded,
  Value<int?> fileSizeBytes,
  Value<DateTime> createdAt,
});
typedef $$MediaFilesTableTableUpdateCompanionBuilder = MediaFilesTableCompanion
    Function({
  Value<int> id,
  Value<String> inspectionUuid,
  Value<String> fieldId,
  Value<String> localPath,
  Value<String?> compressedPath,
  Value<String?> remoteUrl,
  Value<bool> isUploaded,
  Value<int?> fileSizeBytes,
  Value<DateTime> createdAt,
});

class $$MediaFilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MediaFilesTableTable> {
  $$MediaFilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inspectionUuid => $composableBuilder(
      column: $table.inspectionUuid,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fieldId => $composableBuilder(
      column: $table.fieldId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get compressedPath => $composableBuilder(
      column: $table.compressedPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUploaded => $composableBuilder(
      column: $table.isUploaded, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$MediaFilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaFilesTableTable> {
  $$MediaFilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inspectionUuid => $composableBuilder(
      column: $table.inspectionUuid,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fieldId => $composableBuilder(
      column: $table.fieldId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get compressedPath => $composableBuilder(
      column: $table.compressedPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUploaded => $composableBuilder(
      column: $table.isUploaded, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$MediaFilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaFilesTableTable> {
  $$MediaFilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get inspectionUuid => $composableBuilder(
      column: $table.inspectionUuid, builder: (column) => column);

  GeneratedColumn<String> get fieldId =>
      $composableBuilder(column: $table.fieldId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get compressedPath => $composableBuilder(
      column: $table.compressedPath, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<bool> get isUploaded => $composableBuilder(
      column: $table.isUploaded, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MediaFilesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MediaFilesTableTable,
    MediaFilesTableData,
    $$MediaFilesTableTableFilterComposer,
    $$MediaFilesTableTableOrderingComposer,
    $$MediaFilesTableTableAnnotationComposer,
    $$MediaFilesTableTableCreateCompanionBuilder,
    $$MediaFilesTableTableUpdateCompanionBuilder,
    (
      MediaFilesTableData,
      BaseReferences<_$AppDatabase, $MediaFilesTableTable, MediaFilesTableData>
    ),
    MediaFilesTableData,
    PrefetchHooks Function()> {
  $$MediaFilesTableTableTableManager(
      _$AppDatabase db, $MediaFilesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaFilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaFilesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaFilesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> inspectionUuid = const Value.absent(),
            Value<String> fieldId = const Value.absent(),
            Value<String> localPath = const Value.absent(),
            Value<String?> compressedPath = const Value.absent(),
            Value<String?> remoteUrl = const Value.absent(),
            Value<bool> isUploaded = const Value.absent(),
            Value<int?> fileSizeBytes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MediaFilesTableCompanion(
            id: id,
            inspectionUuid: inspectionUuid,
            fieldId: fieldId,
            localPath: localPath,
            compressedPath: compressedPath,
            remoteUrl: remoteUrl,
            isUploaded: isUploaded,
            fileSizeBytes: fileSizeBytes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String inspectionUuid,
            required String fieldId,
            required String localPath,
            Value<String?> compressedPath = const Value.absent(),
            Value<String?> remoteUrl = const Value.absent(),
            Value<bool> isUploaded = const Value.absent(),
            Value<int?> fileSizeBytes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MediaFilesTableCompanion.insert(
            id: id,
            inspectionUuid: inspectionUuid,
            fieldId: fieldId,
            localPath: localPath,
            compressedPath: compressedPath,
            remoteUrl: remoteUrl,
            isUploaded: isUploaded,
            fileSizeBytes: fileSizeBytes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MediaFilesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MediaFilesTableTable,
    MediaFilesTableData,
    $$MediaFilesTableTableFilterComposer,
    $$MediaFilesTableTableOrderingComposer,
    $$MediaFilesTableTableAnnotationComposer,
    $$MediaFilesTableTableCreateCompanionBuilder,
    $$MediaFilesTableTableUpdateCompanionBuilder,
    (
      MediaFilesTableData,
      BaseReferences<_$AppDatabase, $MediaFilesTableTable, MediaFilesTableData>
    ),
    MediaFilesTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$AssetsTableTableTableManager get assetsTable =>
      $$AssetsTableTableTableManager(_db, _db.assetsTable);
  $$FormTemplatesTableTableTableManager get formTemplatesTable =>
      $$FormTemplatesTableTableTableManager(_db, _db.formTemplatesTable);
  $$InspectionsTableTableTableManager get inspectionsTable =>
      $$InspectionsTableTableTableManager(_db, _db.inspectionsTable);
  $$OutboxTableTableTableManager get outboxTable =>
      $$OutboxTableTableTableManager(_db, _db.outboxTable);
  $$MediaFilesTableTableTableManager get mediaFilesTable =>
      $$MediaFilesTableTableTableManager(_db, _db.mediaFilesTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'96b544ff7ce456f0fc1edbdafdf332306a9affed';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
String _$assetsDaoHash() => r'5bb1adbe66682f19bd7e2f9af72f099bdcf9f6f4';

/// See also [assetsDao].
@ProviderFor(assetsDao)
final assetsDaoProvider = Provider<AssetsDao>.internal(
  assetsDao,
  name: r'assetsDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$assetsDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AssetsDaoRef = ProviderRef<AssetsDao>;
String _$inspectionsDaoHash() => r'242e6cad3d8f1a0d23741a9911187a9f0a865b5b';

/// See also [inspectionsDao].
@ProviderFor(inspectionsDao)
final inspectionsDaoProvider = Provider<InspectionsDao>.internal(
  inspectionsDao,
  name: r'inspectionsDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inspectionsDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InspectionsDaoRef = ProviderRef<InspectionsDao>;
String _$outboxDaoHash() => r'55c97e9307c7c6c0e0bfcda21676755cd11deb32';

/// See also [outboxDao].
@ProviderFor(outboxDao)
final outboxDaoProvider = Provider<OutboxDao>.internal(
  outboxDao,
  name: r'outboxDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$outboxDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OutboxDaoRef = ProviderRef<OutboxDao>;
String _$formTemplatesDaoHash() => r'394508a2000bfb8dde5bf8df11939098666defbf';

/// See also [formTemplatesDao].
@ProviderFor(formTemplatesDao)
final formTemplatesDaoProvider = Provider<FormTemplatesDao>.internal(
  formTemplatesDao,
  name: r'formTemplatesDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$formTemplatesDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FormTemplatesDaoRef = ProviderRef<FormTemplatesDao>;
String _$mediaDaoHash() => r'fcdbf08222c95cd5215d73ebc31b95cdac380dba';

/// See also [mediaDao].
@ProviderFor(mediaDao)
final mediaDaoProvider = Provider<MediaDao>.internal(
  mediaDao,
  name: r'mediaDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mediaDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MediaDaoRef = ProviderRef<MediaDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
