import 'package:flutter/material.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/widgets/cards/card_lockprifile.dart';
import 'package:go_router/go_router.dart';

  final luckprofile = LockProfile(
    title: 'Bloqueo de redes sociales', 
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
    state: StateLockProfile.active, 
    appImageUrls: [
      'https://www.freepnglogos.com/uploads/facebook-logo-10.png', 
      'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
      'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
      'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
      'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
      'https://pngimg.com/uploads/instagram/instagram_PNG9.png',
      ]
  );

class LockProfileView extends StatelessWidget {
  const LockProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfiles de bloqueo'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings),
          ),],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Activas'),
            LockProfileCard(profile: luckprofile)
          ],
        ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción que se realizará al presionar el botón
          print('Botón presionado');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
