import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/theme/theme_providers.dart';
import 'package:focustime/presentation/widgets/modal/modal_launch_number.dart';
import 'package:focustime/presentation/widgets/modal/modal_schedule.dart';
import 'package:focustime/presentation/widgets/modal/modal_usage_limit.dart';

class NewLockTypeModal extends ConsumerWidget {

  const NewLockTypeModal({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
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
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const UsageLimitModal(),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Horario'),
                        subtitle: const Text('p.ej. 10:00 am - 04:00 pm'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const ScheduleModal(),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Número de lanzamientos'),
                        subtitle: const Text('p.ej. 300 lanzamientos por día'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const LaunchesLimitModal(),
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
