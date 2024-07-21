import 'package:flutter/material.dart';

class DaySelectButton extends StatefulWidget {
  const DaySelectButton({super.key});

  @override
  _DaySelectButtonState createState() => _DaySelectButtonState();
}

class _DaySelectButtonState extends State<DaySelectButton> {
  // Lista de índices de botones seleccionados
  final List<bool> _selectedButtons = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ToggleButtons(
          isSelected: _selectedButtons,
          onPressed: (int index) {
            setState(() {
              // Cambiar el estado del botón seleccionado
              _selectedButtons[index] = !_selectedButtons[index];
            });
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              
              child: Text('L'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('M'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('M'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('J'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('V'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('S'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('D'),
            ),
          ],
        ),
      );
  }
}