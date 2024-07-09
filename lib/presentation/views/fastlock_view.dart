import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FastLockView extends StatelessWidget {
  const FastLockView({super.key});

  @override
  Widget build(BuildContext context) {
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
          ),],
      ),
      body: const Center(
        child: Text('Fast Lock'),  
      ),
    );
  }
}