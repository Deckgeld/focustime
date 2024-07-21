import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/providers/theme/theme_providers.dart';
import 'package:focustime/presentation/widgets/modal/modal_launch_number.dart';
import 'package:focustime/presentation/widgets/modal/modal_schedule.dart';
import 'package:focustime/presentation/widgets/modal/modal_usage_limit.dart';

class NewLockTypeModal extends ConsumerWidget {
  final Function(LockType) onLockTypeAdded;

  const NewLockTypeModal({super.key, required this.onLockTypeAdded});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: ListView(
              controller: scrollController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Añadir tipo de bloqueo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        title: const Text('Límite de uso'),
                        subtitle: const Text('p.ej. 30 minutos por día'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(context); // Cierra el modal actual
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => UsageLimitModal(
                              onUsageLimitSet: (hours, minutes, selectedOptions) {
                                onLockTypeAdded(LockType(
                                  type: NameLockType.limitUsage,
                                  limit: hours * 60 + minutes,
                                  daysActive: [
                                    DayOfWeek.monday,
                                    DayOfWeek.tuesday,
                                    DayOfWeek.wednesday,
                                    DayOfWeek.thursday,
                                    DayOfWeek.friday,
                                  ],
                                ));
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Horario'),
                        subtitle: const Text('p.ej. 10:00 am - 04:00 pm'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(context); // Cierra el modal actual
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => ScheduleModal(
                              onScheduleSet: (startTime, endTime) {
                                onLockTypeAdded(LockType(
                                  type: NameLockType.schedule,
                                  daysActive: [
                                    DayOfWeek.monday,
                                    DayOfWeek.tuesday,
                                    DayOfWeek.wednesday,
                                    DayOfWeek.thursday,
                                    DayOfWeek.friday,
                                  ],
                                  hoursActive: [startTime, endTime],
                                ));
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Número de lanzamientos'),
                        subtitle: const Text('p.ej. 300 lanzamientos por día'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(context); // Cierra el modal actual
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => LaunchNumberModal(
                              onLaunchNumberSet: (launches) {
                                onLockTypeAdded(LockType(
                                  type: NameLockType.numberLaunch,
                                  limit: launches,
                                  daysActive: [
                                    DayOfWeek.monday,
                                    DayOfWeek.tuesday,
                                    DayOfWeek.wednesday,
                                    DayOfWeek.thursday,
                                    DayOfWeek.friday,
                                  ],
                                ));
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
