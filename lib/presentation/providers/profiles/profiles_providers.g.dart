// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lockProfilesHash() => r'29cba80b9fdf392cf359f99f0a1f2089b878fa98';

/// See also [LockProfiles].
@ProviderFor(LockProfiles)
final lockProfilesProvider =
    NotifierProvider<LockProfiles, List<LockProfile>>.internal(
  LockProfiles.new,
  name: r'lockProfilesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lockProfilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LockProfiles = Notifier<List<LockProfile>>;
String _$newLockProfileHash() => r'f6cad235d5a346ca492550c250d9d1bb9816f6b1';

/// See also [NewLockProfile].
@ProviderFor(NewLockProfile)
final newLockProfileProvider =
    AutoDisposeNotifierProvider<NewLockProfile, LockProfile>.internal(
  NewLockProfile.new,
  name: r'newLockProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newLockProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NewLockProfile = AutoDisposeNotifier<LockProfile>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
