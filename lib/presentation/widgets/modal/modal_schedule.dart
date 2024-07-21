import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';
import 'package:uuid/uuid.dart';

// convertimos el StatefulWidget en un ConsumerStatefulWidget
class ScheduleModal extends ConsumerStatefulWidget {
  const ScheduleModal({super.key});

  @override
  // Ahora sera un ConsumerState
  ConsumerState<ScheduleModal> createState() => _ScheduleModalState();
}

// Ahora extiende de ConsumerState
class _ScheduleModalState extends ConsumerState<ScheduleModal> {
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 16, minute: 0);
  Set<DayOfWeek> selectedDays = {};

  handleDaySelection(Set<DayOfWeek> selections) {
    setState(() {
      selectedDays = selections;  
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (_, scrollController) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Horario'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      final newLockType = LockType(
                      id: const Uuid().v4(),
                      type: NameLockType.schedule,
                      daysActive: selectedDays.toList(),
                      hoursActive: [startTime, endTime],
                    );

                    ref.read(newLockProfileProvider.notifier).addLockType(newLockType);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Días'),
                    DaySelectButton(onSelectionChanged: handleDaySelection),

                    const SizedBox(height: 16),

                    const Text('Comienzo'),
                    ListTile(
                      title: Text(startTime.format(context)),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: startTime,
                        );
                        if (picked != null && picked != startTime) {
                          setState(() {
                            startTime = picked;
                          });
                        }
                      },
                    ),

                    const Text('Final'),
                    ListTile(
                      title: Text(endTime.format(context)),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: endTime,
                        );
                        if (picked != null && picked != endTime) {
                          setState(() {
                            endTime = picked;
                          });
                        }
                      },
                    ),
                    
                  ],
                ),
              ),
            );
          }),
    );
  }

  
}