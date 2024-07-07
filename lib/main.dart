import 'package:flutter/material.dart';
import 'package:focustime/config/theme/app_theme.dart';
import 'package:focustime/presentation/screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: AppTheme(selectColor: 1).getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
