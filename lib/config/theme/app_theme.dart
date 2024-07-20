import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
];

class AppTheme {
  final bool isDarkMode;
  final int selectColor;

  AppTheme({this.selectColor = 2, this.isDarkMode = true})
      : assert(selectColor >= 0, 'Select color must be greater than 0'),
        assert(selectColor < colorList.length,
            'Select color must be less than ${colorList.length}');

  ThemeData getTheme() => ThemeData(
        colorSchemeSeed: colorList[selectColor],
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      );

  AppTheme copyWith({bool? isDarkMode, int? selectColor}) {
    return AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      selectColor: selectColor ?? this.selectColor,
    );
  } 
}

