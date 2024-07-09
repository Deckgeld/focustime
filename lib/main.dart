import 'package:flutter/material.dart';
import 'package:focustime/config/router/app_router.dart';
import 'package:focustime/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme(selectColor: 1).getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
