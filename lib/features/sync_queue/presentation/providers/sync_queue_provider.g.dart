// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$outboxItemsStreamHash() => r'c6ec69e48d07603b565ba8cb06826787ddbd4762';

/// See also [outboxItemsStream].
@ProviderFor(outboxItemsStream)
final outboxItemsStreamProvider =
    AutoDisposeStreamProvider<List<OutboxTableData>>.internal(
  outboxItemsStream,
  name: r'outboxItemsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$outboxItemsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OutboxItemsStreamRef
    = AutoDisposeStreamProviderRef<List<OutboxTableData>>;
String _$outboxPendingCountHash() =>
    r'846f5f32de7be640975062504ee99329c0b6bd90';

/// See also [outboxPendingCount].
@ProviderFor(outboxPendingCount)
final outboxPendingCountProvider = AutoDisposeStreamProvider<int>.internal(
  outboxPendingCount,
  name: r'outboxPendingCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$outboxPendingCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OutboxPendingCountRef = AutoDisposeStreamProviderRef<int>;
String _$syncQueueNotifierHash() => r'11356cec050c21685a733b4547cd2e092b79a71d';

/// See also [SyncQueueNotifier].
@ProviderFor(SyncQueueNotifier)
final syncQueueNotifierProvider = AutoDisposeNotifierProvider<SyncQueueNotifier,
    AsyncValue<SyncResult?>>.internal(
  SyncQueueNotifier.new,
  name: r'syncQueueNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncQueueNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncQueueNotifier = AutoDisposeNotifier<AsyncValue<SyncResult?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
