import 'package:flutter/material.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';

class ScheduleModal extends StatelessWidget {
  final Function(TimeOfDay start, TimeOfDay end) onScheduleSet;

  const ScheduleModal({super.key, required this.onScheduleSet});

  @override
  Widget build(BuildContext context) {
    TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 16, minute: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              onScheduleSet(startTime, endTime);
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
            const DaySelectButton(),

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
                  startTime = picked;
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
                  endTime = picked;
                }
              },
            ),
            // Añade aquí más opciones si es necesario
          ],
        ),
      ),
    );
  }
}
