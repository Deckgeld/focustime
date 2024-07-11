import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FastLockView extends StatelessWidget {
  const FastLockView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Lock'),
        actions: [
          IconButton(
            onPressed: () {
              // Acción que se realizará al presionar el botón
              context.push('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Agrega aquí el CupertinoTimerPicker
            SizedBox(
              height: 200, // Ajusta la altura según necesites
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode
                    .hm, // Modo: horas, minutos, segundos
                onTimerDurationChanged: (Duration changedTimer) {
                  // Aquí manejas el valor seleccionado
                  // print('El tiempo seleccionado es: $changedTimer');
                },
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mostrar Boton de pausa',
                      style: TextStyle(fontSize: 17),
                    ),
                    Switch(value: true, onChanged: (value) {})
                  ]),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bóveda de aplicaciones',
                        style: TextStyle(fontSize: 17),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aplicaciones a las que se puede acceder',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              'con el bloqueo activado',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.add_circle, size: 40, color: colors.primary),
                ],
              ),
            ),

            const SizedBox(height: 60),

            FilledButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(
                    const Size(50, 50)), // Tamaño mínimo del botón
              ),
              child: const Text('Bloquear'),
              onPressed: () {
                // Acción del botón
              },
            ),
          ],
        ),
      ),
    );
  }
}
