import 'package:flutter/material.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';

class LaunchNumberModal extends StatelessWidget {
  final Function(int launches) onLaunchNumberSet;

  const LaunchNumberModal({super.key, required this.onLaunchNumberSet});

  @override
  Widget build(BuildContext context) {
    int launches = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Número de lanzamientos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              onLaunchNumberSet(launches);
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

            TextField(
              decoration: const InputDecoration(labelText: 'Lanzamientos'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                launches = int.tryParse(value) ?? 0;
              },
            ),
            // Añade aquí más opciones si es necesario
          ],
        ),
      ),
    );
  }
}
