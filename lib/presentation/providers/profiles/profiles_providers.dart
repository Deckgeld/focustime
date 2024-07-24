import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:installed_apps/app_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'profiles_providers.g.dart';

const uuid = Uuid();

@Riverpod(keepAlive: true)
class LockProfiles extends _$LockProfiles {
  @override
  List<LockProfile> build() => [];
  
  void creadProfile( LockProfile newProfile ) {
    state = [
      ...state,
      newProfile
    ];
  }

  void changeState( StateLockProfile newState, String id ) {
    state = state.map((profile) {
      if (profile.id == id) {
        return profile.copyWith(
          stateProfile: newState
        );
      }
      return profile;
    }).toList();
  }

  void deleteProfile( String id ) {
    state = state.where((profile) => profile.id != id).toList();
  }

  void updateProfile(LockProfile newProfile) {
    state = state.map((profile) {
      if (profile.id == newProfile.id) {
        return profile.copyWith(
          title: newProfile.title,
          lockTypes: newProfile.lockTypes,
          apps: newProfile.apps,
          isBlockNotifications: newProfile.isBlockNotifications
        );
      }
      return profile;
    }).toList();
  }
}

@Riverpod()
class NewLockProfile extends _$NewLockProfile {
  @override
  LockProfile build() {
    return LockProfile( 
      id: uuid.v4(),
      stateProfile: StateLockProfile.active,
      lockTypes: [],
      apps: [],
      isBlockNotifications: true
    );
  }

  void changeTitle( String newTitle ) {
    if (newTitle.isEmpty) return;
    state = state.copyWith(
      title: newTitle
    );
  }

  void addLockType( LockType newLockType ) {
    state = state.copyWith(
      lockTypes: [
        ...state.lockTypes,
        newLockType
      ]
    );
  }

  void removeLockType( String id ) {
    state = state.copyWith(
      lockTypes: state.lockTypes.where((lockType) => lockType.id != id).toList()
    );
  }

  void addApps(List<AppInfo> apps){
    state = state.copyWith(
      apps: apps
    );
  }

  void toggleBlockNotifications() {
    state = state.copyWith(
      isBlockNotifications: !state.isBlockNotifications
    );
  }

  void updateLockType(LockType lockType) {
    state = state.copyWith(
      lockTypes: state.lockTypes.map((lt) {
        if (lt.id == lockType.id) {
          return lockType;
        }
        return lt;
      }).toList()
    );
  }

  void createNewProfileWithExisting(LockProfile profile) {
  state = state.copyWith(
    id: profile.id,
    title: profile.title,
    lockTypes: profile.lockTypes,
    isBlockNotifications: profile.isBlockNotifications,
    stateProfile: profile.stateProfile,
    apps: profile.apps
  );
}

}