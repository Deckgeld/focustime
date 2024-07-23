import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/modal/modal_launch_number.dart';
import 'package:focustime/presentation/widgets/modal/modal_schedule.dart';
import 'package:focustime/presentation/widgets/modal/modal_usage_limit.dart';

class LockTypeCard extends ConsumerWidget {
  final LockType lockType;

  const LockTypeCard({super.key, required this.lockType});

  String getDayShortName(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.monday:
        return 'LUN';
      case DayOfWeek.tuesday:
        return 'MAR';
      case DayOfWeek.wednesday:
        return 'MIE';
      case DayOfWeek.thursday:
        return 'JUE';
      case DayOfWeek.friday:
        return 'VIE';
      case DayOfWeek.saturday:
        return 'SAB';
      case DayOfWeek.sunday:
        return 'DOM';
      default:
        return '';
    }
  }

  String getTypeName(NameLockType type) {
    switch (type) {
      case NameLockType.limitUsage:
        return 'Límite de Uso';
      case NameLockType.schedule:
        return 'Horario';
      case NameLockType.numberLaunch:
        return 'Número de Lanzamientos';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                if (lockType.type == NameLockType.limitUsage) {
                  return UsageLimitModal(lockType: lockType);
                } else if (lockType.type == NameLockType.schedule) {
                  return ScheduleModal(lockType: lockType);
                } else {
                  return LaunchesLimitModal(lockType: lockType);
                }
              });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lockType.daysActive
                        .map((day) => getDayShortName(day))
                        .join('  '),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.menu), // Icono del botón
                    onSelected: (String result) {
                      // Acción al seleccionar una opción
                      // Puedes usar un switch o if-else para manejar diferentes acciones basadas en 'result'
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: const Text('Editar'),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                if (lockType.type == NameLockType.limitUsage) {
                                  return UsageLimitModal(lockType: lockType);
                                } else if (lockType.type ==
                                    NameLockType.schedule) {
                                  return ScheduleModal(lockType: lockType);
                                } else {
                                  return LaunchesLimitModal(lockType: lockType);
                                }
                              });
                        },
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: const Text('Eliminar'),
                        onTap: () => ref
                            .read(newLockProfileProvider.notifier)
                            .removeLockType(lockType.id),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                getTypeName(lockType.type),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              if (lockType.type == NameLockType.schedule &&
                  lockType.hoursActive != null)
                Text(
                  '${lockType.hoursActive!.first.format(context)} - ${lockType.hoursActive!.last.format(context)}',
                  style: const TextStyle(fontSize: 14),
                ),
              if (lockType.type == NameLockType.limitUsage &&
                  lockType.limit != null)
                Text(
                  '${lockType.limit} minutos diarios  / ${lockType.isByBlock! ? 'bloque' : 'app'}',
                  style: const TextStyle(fontSize: 14),
                ),
              if (lockType.type == NameLockType.numberLaunch &&
                  lockType.limit != null)
                Text(
                  '${lockType.limit} lanzamientos diarios',
                  style: const TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
