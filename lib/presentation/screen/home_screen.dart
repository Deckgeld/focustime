import 'package:flutter/material.dart';
import 'package:focustime/presentation/widgets/shared/custom_buttom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  final Widget childView;

  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}