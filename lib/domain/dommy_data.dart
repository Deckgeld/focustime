import 'package:flutter/material.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/domain/entitites/locktype.dart';

final List<LockProfile> lockProfiles = [
  LockProfile(
      title: 'Bloqueo de redes sociales', 
      state: StateLockProfile.active, 
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
      title: 'Bloqueo de juegos', 
      state: StateLockProfile.inactive, 

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