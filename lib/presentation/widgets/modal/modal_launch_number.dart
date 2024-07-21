import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';

class LaunchesLimitModal extends StatelessWidget {
  const LaunchesLimitModal({super.key});

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
            // const DaySelectButton(),

            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(labelText: 'Lanzamientos'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
