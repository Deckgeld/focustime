import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/cards/card_locktype.dart';
import 'package:focustime/presentation/widgets/modal/modal_newlocktype.dart';

class NewProfileScreen extends ConsumerWidget {
  NewProfileScreen({super.key});

  final TextEditingController _nombrePerfilController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
  final newLockProfile = ref.watch(newLockProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                controller: _nombrePerfilController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del perfil',
                  border: OutlineInputBorder(),
                ),
              ),
              
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.lock),
                  const SizedBox(width: 8),
                  const Text('Tipo de bloqueo'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const NewLockTypeModal(),
                      );
                    },
                    child: const Text('Añadir'),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newLockProfile.lockTypes.length,
                itemBuilder: (context, index) {
                  return LockTypeCard(
                    lockType: newLockProfile.lockTypes[index],
                  );
                },
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  const Icon(Icons.apps),
                  const SizedBox(width: 8),
                  const Text('Aplicaciones bloqueadas'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí podrías abrir un selector de aplicaciones
                    },
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Center(child: Text('Seleccione las aplicaciones')),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.notifications_off),
                  const SizedBox(width: 8),
                  const Text('Bloquear notificaciones'),
                  const Spacer(),
                  Checkbox(
                    value: newLockProfile.isBlockNotifications, 
                    onChanged: (value) => ref.read(newLockProfileProvider.notifier).toggleBlockNotifications()
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    ref.read(newLockProfileProvider.notifier).changeTitle(_nombrePerfilController.text);
                    ref.read(lockProfilesProvider.notifier).creadProfile(ref.read(newLockProfileProvider));
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
