import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LockProfileView extends StatelessWidget {
  const LockProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings),
          ),],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Home Screen'),
            ElevatedButton(onPressed: (){}, child:  const Text('Button')),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción que se realizará al presionar el botón
          print('Botón presionado');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
