import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/cards/card_locktype.dart';
import 'package:focustime/presentation/widgets/modal/modal_list_apps.dart';
import 'package:focustime/presentation/widgets/modal/modal_newlocktype.dart';

class NewProfileScreen extends ConsumerStatefulWidget {
  final LockProfile? profile;
  const NewProfileScreen({this.profile, super.key});
  @override
  ConsumerState<NewProfileScreen> createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends ConsumerState<NewProfileScreen> {
  late TextEditingController _nombrePerfilController;

  @override
  void initState() {
    super.initState();
    _nombrePerfilController = TextEditingController(text: widget.profile?.title ?? '');

    // Si el perfil ya existe, actualiza el estado del proveedor con los datos del perfil
    Future.microtask(() {
    if (widget.profile != null) {
      ref.read(newLockProfileProvider.notifier).createNewProfileWithExisting(widget.profile!);
    }
  });
  }

  @override
  void dispose() {
    _nombrePerfilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final newLockProfile = ref.watch(newLockProfileProvider);
  

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile != null ? 'Editar perfil' : 'Nuevo perfil'),
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
                    child: const Text('Seleccionar'),

                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ListAppsModal(),
                      );
                    },
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
                    if (widget.profile != null){
                      ref.read(newLockProfileProvider.notifier).changeTitle(_nombrePerfilController.text);
                      ref.read(lockProfilesProvider.notifier).updateProfile(ref.watch(newLockProfileProvider));
                      Navigator.pop(context); 
                    }else{
                      ref.read(newLockProfileProvider.notifier).changeTitle(_nombrePerfilController.text);
                      ref.read(lockProfilesProvider.notifier).creadProfile(ref.read(newLockProfileProvider));
                      Navigator.pop(context);
                    }
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
