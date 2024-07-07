import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
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
