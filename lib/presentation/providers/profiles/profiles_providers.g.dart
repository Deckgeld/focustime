// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lockProfilesHash() => r'16c4fb683132cbe9ea22456ff804fca9184d4f99';

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
String _$newLockProfileHash() => r'6fca831dc48b557f405af48fca73491446391eec';

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
