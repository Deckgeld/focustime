import 'package:flutter/material.dart';
import 'package:focustime/domain/entitites/locktype.dart';

class DaySelectButton extends StatefulWidget {
  final Function(Set<DayOfWeek>) onSelectionChanged;

  const DaySelectButton({Key? key, required this.onSelectionChanged}) : super(key: key);

  @override
  _DaySelectButtonState createState() => _DaySelectButtonState();
}

class _DaySelectButtonState extends State<DaySelectButton> {
  final Set<DayOfWeek> _selectedDays = {};

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        isSelected: DayOfWeek.values.map((day) => _selectedDays.contains(day)).toList(),
        onPressed: (int index) {
          setState(() {
            final day = DayOfWeek.values[index];
            if (_selectedDays.contains(day)) {
              _selectedDays.remove(day);
            } else {
              _selectedDays.add(day);
            }
            widget.onSelectionChanged(_selectedDays);
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