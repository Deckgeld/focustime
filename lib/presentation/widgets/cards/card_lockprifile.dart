import 'package:flutter/material.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/widgets/blocked_apps_icon.dart';

class LockProfileCard extends StatelessWidget {
  final LockProfile profile;

  LockProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // Mostrar los iconos de las aplicaciones bloqueadas
              BlockedAppsIcons(appImageUrls: profile.appImageUrls),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Icon(Icons.menu, color: colors.primary),
              ),

            ]),

            const SizedBox(height: 8),
            // Título del perfil y el icono de menú
            Text(
              profile.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),
            // Mostrar los tipos de bloqueo
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: profile.lockTypes.map((lockType) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    // lockTypeDescription(lockType),
                    lockTypeDescription(lockType),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            // Estado del perfil y el interruptor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  profile.state == StateLockProfile.inactive ? 'Inactivo' : '',
                  style: TextStyle(fontSize: 16, color: colors.primary),
                ),
                Switch(
                  value: profile.state == StateLockProfile.active,
                  onChanged: (value) {
                    // Aquí puedes manejar el cambio de estado del switch
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Descripción del tipo de bloqueo
  String lockTypeDescription(LockType lockType) {
    switch (lockType.type) {
      case NameLockType.limitUsage:
        return 'Límite ${lockType.limit} minutos/app';
      case NameLockType.schedule:
        String startMinute =
            lockType.hoursActive!.first.minute.toString().padLeft(2, '0');
        String endMinute =
            lockType.hoursActive!.last.minute.toString().padLeft(2, '0');

        return '${lockType.hoursActive!.first.hour}:$startMinute AM - ${lockType.hoursActive!.last.hour}:$endMinute PM';
      default:
        return 'Número de lanzamientos ${lockType.limit} veces/día';
    }
  }
}
