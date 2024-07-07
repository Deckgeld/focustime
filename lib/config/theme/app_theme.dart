import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
];

class AppTheme {
  final int selectColor;

  AppTheme({required this.selectColor})
      : assert(selectColor >= 0, 'Select color must be greater than 0'),
        assert(selectColor < colorList.length, 'Select color must be less than ${colorList.length}');

  ThemeData getTheme() => ThemeData(
        //useMaterial3: true,
        colorSchemeSeed: colorList[selectColor],
      );
}