import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/cards/blocked_apps_icon.dart';
import 'package:go_router/go_router.dart';

class LockProfileCard extends ConsumerWidget {
  final LockProfile profile;

  const LockProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          // Acción al presionar el card
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Mostrar los iconos de las aplicaciones bloqueadas
                BlockedAppsIcons(appImageUrls: profile.appImageUrls),

                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu), // Icono del botón
                  onSelected: (String result) {
                    // Acción al seleccionar una opción
                    // Puedes usar un switch o if-else para manejar diferentes acciones basadas en 'result'
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'opcion1',
                      child: const Text('Pausar'),
                      onTap: () {
                        
                      },
                    ),
                    PopupMenuItem<String>(
                      value: 'opcion2',
                      child: const Text('Editar'),
                      onTap: () {
                        context.push('/newprofile/${profile.id}');
                      },
                    ),
                    PopupMenuItem<String>(
                      value: 'opcion3',
                      child: const Text('Eliminar'),
                      onTap: () {
                        ref.read(lockProfilesProvider.notifier).deleteProfile(profile.id);
                      },
                    ),
                  ],
                ),
              ]),

              const SizedBox(height: 8),
              Row(
                children: [
                  if (profile.stateProfile == StateLockProfile.paused) ...[
                    const Icon(Icons.pause),
                  ] else if (profile.stateProfile == StateLockProfile.active) ...[
                    profile.isBlockNotifications
                      ? const Icon(Icons.notifications_off_outlined)
                      : const Icon(Icons.notifications_active_outlined),
                  ] else ...[
                    const Icon(Icons.block),
                  ],
                  
                  const SizedBox(width: 8),                  

                  Text(
                    profile.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              // Mostrar los tipos de bloqueo
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: profile.lockTypes.map((lockType) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
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
                    profile.stateProfile == StateLockProfile.inactive
                        ? 'Inactivo'
                        : '',
                    style: TextStyle(fontSize: 16, color: colors.primary),
                  ),
                  Switch(
                    value: profile.stateProfile == StateLockProfile.active ||
                        profile.stateProfile == StateLockProfile.paused,
                    onChanged: (value) {
                      // Cambiar el estado del perfil
                      ref.read(lockProfilesProvider.notifier).changeState(
                            value
                                ? StateLockProfile.active
                                : StateLockProfile.inactive,
                            profile.id,
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Descripción del tipo de bloqueo
  String lockTypeDescription(LockType lockType) {
    switch (lockType.type) {
      case NameLockType.limitUsage:
        return 'Límite ${lockType.limit} minutos / ${lockType.isByBlock! ? 'bloque' : 'app'}';
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
