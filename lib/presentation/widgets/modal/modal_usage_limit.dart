import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';

class UsageLimitModal extends StatefulWidget {
  final Function(int hours, int minutes, Set<int> selectedOptions) onUsageLimitSet;

  const UsageLimitModal({super.key, required this.onUsageLimitSet});

  @override
  _UsageLimitModalState createState() => _UsageLimitModalState();
}

class _UsageLimitModalState extends State<UsageLimitModal> {
  int _hours = 0;
  int _minutes = 0;
  Set<int> _selectedOptions = {1}; // Estado inicial del segmented button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Límite de uso'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              widget.onUsageLimitSet(_hours, _minutes, _selectedOptions);
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

            const Text('Límite'),
            SizedBox(
              height: 200, // Ajusta la altura según necesites
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm, // Modo: horas, minutos
                onTimerDurationChanged: (Duration changedTimer) {
                  setState(() {
                    _hours = changedTimer.inHours;
                    _minutes = changedTimer.inMinutes % 60;
                  });
                },
              ),
            ),


            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: const Text('Bloquear Por:'),
            ),
            Center(
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 1, icon: Text('Bloque')),
                  ButtonSegment(value: 2, icon: Text('Aplicacion')),
                ],
                selected: _selectedOptions,
                onSelectionChanged: (Set<int> value) {
                  setState(() {
                    _selectedOptions = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
