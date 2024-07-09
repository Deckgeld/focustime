import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  int getCurrentIndex (BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    switch (location) {
      case '/lockprofile':
        return 0;
      case '/fastlock':
        return 1;
      default:
        return 0;
    }
  }

  void onItemTapped( BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/fastlock');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: getCurrentIndex(context),
      onTap: (index) => onItemTapped(context, index),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfiles'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock_outline),
          label: 'Bloqueo rapido'
        ),
      ]
    );
  }
}