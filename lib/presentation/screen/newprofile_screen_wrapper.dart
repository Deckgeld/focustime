import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/screen/newprofile_screen.dart';
// Asegúrate de importar tus proveedores correctamente

class NewProfileScreenWrapper extends ConsumerWidget {
  final String? id;
  const NewProfileScreenWrapper({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id == null) {
      return const NewProfileScreen();
    }

    final profile = ref.watch(lockProfilesProvider).firstWhere((element) => element.id == id);
    return NewProfileScreen(profile: profile);
  }
}