// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assetDetailHash() => r'1d3afeb6b065db4e85d55eaae29b455df7851536';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [assetDetail].
@ProviderFor(assetDetail)
const assetDetailProvider = AssetDetailFamily();

/// See also [assetDetail].
class AssetDetailFamily extends Family<AsyncValue<AssetsTableData?>> {
  /// See also [assetDetail].
  const AssetDetailFamily();

  /// See also [assetDetail].
  AssetDetailProvider call(
    String assetId,
  ) {
    return AssetDetailProvider(
      assetId,
    );
  }

  @override
  AssetDetailProvider getProviderOverride(
    covariant AssetDetailProvider provider,
  ) {
    return call(
      provider.assetId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assetDetailProvider';
}

/// See also [assetDetail].
class AssetDetailProvider extends AutoDisposeFutureProvider<AssetsTableData?> {
  /// See also [assetDetail].
  AssetDetailProvider(
    String assetId,
  ) : this._internal(
          (ref) => assetDetail(
            ref as AssetDetailRef,
            assetId,
          ),
          from: assetDetailProvider,
          name: r'assetDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assetDetailHash,
          dependencies: AssetDetailFamily._dependencies,
          allTransitiveDependencies:
              AssetDetailFamily._allTransitiveDependencies,
          assetId: assetId,
        );

  AssetDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assetId,
  }) : super.internal();

  final String assetId;

  @override
  Override overrideWith(
    FutureOr<AssetsTableData?> Function(AssetDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssetDetailProvider._internal(
        (ref) => create(ref as AssetDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assetId: assetId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AssetsTableData?> createElement() {
    return _AssetDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetDetailProvider && other.assetId == assetId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assetId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssetDetailRef on AutoDisposeFutureProviderRef<AssetsTableData?> {
  /// The parameter `assetId` of this provider.
  String get assetId;
}

class _AssetDetailProviderElement
    extends AutoDisposeFutureProviderElement<AssetsTableData?>
    with AssetDetailRef {
  _AssetDetailProviderElement(super.provider);

  @override
  String get assetId => (origin as AssetDetailProvider).assetId;
}

String _$assetInspectionsHash() => r'6ecfcdd8c0959923b92989415878b48cd74e188b';

/// See also [assetInspections].
@ProviderFor(assetInspections)
const assetInspectionsProvider = AssetInspectionsFamily();

/// See also [assetInspections].
class AssetInspectionsFamily
    extends Family<AsyncValue<List<InspectionsTableData>>> {
  /// See also [assetInspections].
  const AssetInspectionsFamily();

  /// See also [assetInspections].
  AssetInspectionsProvider call(
    String assetId,
  ) {
    return AssetInspectionsProvider(
      assetId,
    );
  }

  @override
  AssetInspectionsProvider getProviderOverride(
    covariant AssetInspectionsProvider provider,
  ) {
    return call(
      provider.assetId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assetInspectionsProvider';
}

/// See also [assetInspections].
class AssetInspectionsProvider
    extends AutoDisposeStreamProvider<List<InspectionsTableData>> {
  /// See also [assetInspections].
  AssetInspectionsProvider(
    String assetId,
  ) : this._internal(
          (ref) => assetInspections(
            ref as AssetInspectionsRef,
            assetId,
          ),
          from: assetInspectionsProvider,
          name: r'assetInspectionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assetInspectionsHash,
          dependencies: AssetInspectionsFamily._dependencies,
          allTransitiveDependencies:
              AssetInspectionsFamily._allTransitiveDependencies,
          assetId: assetId,
        );

  AssetInspectionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assetId,
  }) : super.internal();

  final String assetId;

  @override
  Override overrideWith(
    Stream<List<InspectionsTableData>> Function(AssetInspectionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssetInspectionsProvider._internal(
        (ref) => create(ref as AssetInspectionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assetId: assetId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<InspectionsTableData>> createElement() {
    return _AssetInspectionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetInspectionsProvider && other.assetId == assetId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assetId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssetInspectionsRef
    on AutoDisposeStreamProviderRef<List<InspectionsTableData>> {
  /// The parameter `assetId` of this provider.
  String get assetId;
}

class _AssetInspectionsProviderElement
    extends AutoDisposeStreamProviderElement<List<InspectionsTableData>>
    with AssetInspectionsRef {
  _AssetInspectionsProviderElement(super.provider);

  @override
  String get assetId => (origin as AssetInspectionsProvider).assetId;
}

String _$assetHasPendingSyncHash() =>
    r'52885c3b728fa9d506a3423ba5266c625c268ff6';

/// See also [assetHasPendingSync].
@ProviderFor(assetHasPendingSync)
const assetHasPendingSyncProvider = AssetHasPendingSyncFamily();

/// See also [assetHasPendingSync].
class AssetHasPendingSyncFamily extends Family<AsyncValue<bool>> {
  /// See also [assetHasPendingSync].
  const AssetHasPendingSyncFamily();

  /// See also [assetHasPendingSync].
  AssetHasPendingSyncProvider call(
    String assetId,
  ) {
    return AssetHasPendingSyncProvider(
      assetId,
    );
  }

  @override
  AssetHasPendingSyncProvider getProviderOverride(
    covariant AssetHasPendingSyncProvider provider,
  ) {
    return call(
      provider.assetId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assetHasPendingSyncProvider';
}

/// See also [assetHasPendingSync].
class AssetHasPendingSyncProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [assetHasPendingSync].
  AssetHasPendingSyncProvider(
    String assetId,
  ) : this._internal(
          (ref) => assetHasPendingSync(
            ref as AssetHasPendingSyncRef,
            assetId,
          ),
          from: assetHasPendingSyncProvider,
          name: r'assetHasPendingSyncProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assetHasPendingSyncHash,
          dependencies: AssetHasPendingSyncFamily._dependencies,
          allTransitiveDependencies:
              AssetHasPendingSyncFamily._allTransitiveDependencies,
          assetId: assetId,
        );

  AssetHasPendingSyncProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assetId,
  }) : super.internal();

  final String assetId;

  @override
  Override overrideWith(
    Stream<bool> Function(AssetHasPendingSyncRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssetHasPendingSyncProvider._internal(
        (ref) => create(ref as AssetHasPendingSyncRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assetId: assetId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _AssetHasPendingSyncProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetHasPendingSyncProvider && other.assetId == assetId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assetId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssetHasPendingSyncRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `assetId` of this provider.
  String get assetId;
}

class _AssetHasPendingSyncProviderElement
    extends AutoDisposeStreamProviderElement<bool> with AssetHasPendingSyncRef {
  _AssetHasPendingSyncProviderElement(super.provider);

  @override
  String get assetId => (origin as AssetHasPendingSyncProvider).assetId;
}

String _$assetDetailNotifierHash() =>
    r'e77ae3871a38cc218c6f3312d6aec2db9f0d7539';

/// See also [AssetDetailNotifier].
@ProviderFor(AssetDetailNotifier)
final assetDetailNotifierProvider =
    AutoDisposeNotifierProvider<AssetDetailNotifier, AsyncValue<void>>.internal(
  AssetDetailNotifier.new,
  name: r'assetDetailNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$assetDetailNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AssetDetailNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
