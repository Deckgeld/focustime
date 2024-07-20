import 'package:flutter/material.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'profile_providers.g.dart';

const uuid = Uuid();

@Riverpod(keepAlive: true)
class lockProfiles extends _$lockProfiles {
  @override
  List<LockProfile> build() => [
    LockProfile(
      id: uuid.v4(),
      title: 'Bloqueo de redes sociales', 
      stateProfile: StateLockProfile.active, 
      lockTypes: [
        LockType(
          type: NameLockType.limitUsage, 
          limit: 30, 
          daysActive: [
            DayOfWeek.monday, 
            DayOfWeek.tuesday, 
            DayOfWeek.wednesday, 
            DayOfWeek.thursday, 
            DayOfWeek.friday
          ]
        ),
        LockType(
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
      stateProfile: StateLockProfile.inactive, 

      lockTypes: [
        LockType(
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
  
  void creadTodo( LockProfile newProfile ) {
    state = [
      ...state,
      newProfile
    ];
  }

  void toggleState( StateLockProfile newState, String id ) {
    state = state.map((profile) {
      if (profile.id == id) {
        return profile.copyWith(
          stateProfile: newState
          // completedAt: todo.completedAt == null ? DateTime.now() : null,
        );
      }
      return profile;
    }).toList();
  }
}