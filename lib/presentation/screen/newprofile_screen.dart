import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/cards/cards.dart';
import 'package:focustime/presentation/widgets/modal/modals.dart';

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
    _nombrePerfilController =
        TextEditingController(text: widget.profile?.title ?? '');
    // Si el perfil ya existe, actualiza el estado del proveedor con los datos del perfil
    Future.microtask(() {
      if (widget.profile != null) {
        ref
            .read(newLockProfileProvider.notifier)
            .createNewProfileWithExisting(widget.profile!);
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
    final appIcons = newLockProfile.apps.map((app) => app.icon).toList();
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
              newLockProfile.lockTypes.isEmpty
                  ? const Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(child: Text('Todavia no hay ninguno')),
                      ),
                    )
                  : ListView.builder(
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
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: appIcons.isEmpty ? 50 : 20),
                  child: Center(
                    child: appIcons.isEmpty
                        ? const Text('Seleccione las aplicaciones')
                        : BlockedAppsIcons(
                            appIcons: appIcons,
                            height: 40,
                            width: 40,
                            limit: 11,
                          ),
                  ),
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
                      onChanged: (value) => ref
                          .read(newLockProfileProvider.notifier)
                          .toggleBlockNotifications()),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    if (widget.profile != null) {
                      ref
                          .read(newLockProfileProvider.notifier)
                          .changeTitle(_nombrePerfilController.text);
                      ref
                          .read(lockProfilesProvider.notifier)
                          .updateProfile(ref.watch(newLockProfileProvider));
                      Navigator.pop(context);
                    } else {
                      ref
                          .read(newLockProfileProvider.notifier)
                          .changeTitle(_nombrePerfilController.text);
                      ref
                          .read(lockProfilesProvider.notifier)
                          .creadProfile(ref.read(newLockProfileProvider));
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
