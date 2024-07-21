import 'package:flutter/material.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'profiles_providers.g.dart';

const uuid = Uuid();

@Riverpod(keepAlive: true)
class LockProfiles extends _$LockProfiles {
  @override
  List<LockProfile> build() => [
    LockProfile(
      id: uuid.v4(),
      title: 'Bloqueo de redes sociales', 
      stateProfile: StateLockProfile.active, 
      lockTypes: [
        LockType(
          id: uuid.v4(),
          type: NameLockType.limitUsage, 
          limit: 30, 
          daysActive: [
            DayOfWeek.monday, 
            DayOfWeek.tuesday, 
            DayOfWeek.wednesday, 
            DayOfWeek.thursday, 
            DayOfWeek.friday
          ],
          isByBlock: true
        ),
        LockType(
          id: uuid.v4(),
          type: NameLockType.numberLaunch, 
          limit: 300, 
          daysActive: [
            DayOfWeek.monday, 
            DayOfWeek.tuesday, 
            DayOfWeek.wednesday, 
            DayOfWeek.thursday, 
            DayOfWeek.friday
          ]
        ),
      ],

      appImageUrls: [
        'https://www.freepnglogos.com/uploads/facebook-logo-10.png', 
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        ]
    ),
    LockProfile(
      id: uuid.v4(),
      title: 'Bloqueo de juegos', 
      stateProfile: StateLockProfile.paused, 

      lockTypes: [
        LockType(
          id: uuid.v4(),
          type: NameLockType.numberLaunch, 
          limit: 3000, 
          daysActive: [
            DayOfWeek.monday, 
            DayOfWeek.tuesday, 
            DayOfWeek.wednesday, 
            DayOfWeek.thursday, 
            DayOfWeek.friday
          ]
        ),
        LockType(
          id: uuid.v4(),
          type: NameLockType.schedule, 
          hoursActive: [
            const TimeOfDay(hour: 8, minute: 00), 
            const TimeOfDay(hour: 12, minute: 00)
          ],
          daysActive: [
            DayOfWeek.monday, 
            DayOfWeek.tuesday, 
            DayOfWeek.wednesday, 
            DayOfWeek.thursday, 
            DayOfWeek.friday
          ]
        ),
      ],

      appImageUrls: [
        'https://www.freepnglogos.com/uploads/facebook-logo-10.png', 
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        ]
    ),
    LockProfile(
      id: uuid.v4(),
      title: 'Bloqueo de juegos', 
      stateProfile: StateLockProfile.inactive, 

      lockTypes: [
        LockType(
          id: uuid.v4(),
          type: NameLockType.numberLaunch, 
          limit: 3000, 
          daysActive: [
            DayOfWeek.monday, 
            DayOfWeek.tuesday, 
            DayOfWeek.wednesday, 
            DayOfWeek.thursday, 
            DayOfWeek.friday
          ]
        ),
        LockType(
          id: uuid.v4(),
          type: NameLockType.schedule, 
          hoursActive: [
            const TimeOfDay(hour: 8, minute: 00), 
            const TimeOfDay(hour: 12, minute: 00)
          ],
          daysActive: [
            DayOfWeek.monday, 
            DayOfWeek.tuesday, 
            DayOfWeek.wednesday, 
            DayOfWeek.thursday, 
            DayOfWeek.friday
          ]
        ),
      ],

      appImageUrls: [
        'https://www.freepnglogos.com/uploads/facebook-logo-10.png', 
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
        ]
    ),
  
  ];
  
  void creadProfile( LockProfile newProfile ) {
    state = [
      ...state,
      newProfile
    ];
  }

  void chageState( StateLockProfile newState, String id ) {
    state = state.map((profile) {
      if (profile.id == id) {
        return profile.copyWith(
          stateProfile: newState
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
      appImageUrls: [],
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

  void addAppImageUrl( String newUrl ) {
    state = state.copyWith(
      appImageUrls: [
        ...state.appImageUrls,
        newUrl
      ]
    );
  }

  void removeAppImageUrl( String url ) {
    state = state.copyWith(
      appImageUrls: state.appImageUrls.where((appImageUrl) => appImageUrl != url).toList()
    );
  }

  void toggleBlockNotifications() {
    state = state.copyWith(
      isBlockNotifications: !state.isBlockNotifications
    );
  }

  void updateLockType(LockType lockType) {}

}