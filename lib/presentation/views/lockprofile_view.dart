import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/lockprofile.dart';
import 'package:focustime/presentation/providers/providers.dart';
import 'package:focustime/presentation/widgets/cards/card_lockprifile.dart';
import 'package:go_router/go_router.dart';

class LockProfileView extends ConsumerWidget {
  const LockProfileView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lockProfiles = ref.watch(lockProfilesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfiles de bloqueo'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80), // Añade un padding en la parte inferior
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _CardsCategory(title: 'Activas', type: StateLockProfile.active, profiles: lockProfiles),
              _CardsCategory(title: 'Pausadas', type: StateLockProfile.paused, profiles: lockProfiles),
              _CardsCategory(title: 'Inactivas', type: StateLockProfile.inactive, profiles: lockProfiles),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/newprofile');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CardsCategory extends StatelessWidget {
  final String title;
  final StateLockProfile type;
  final List<LockProfile> profiles;

  const _CardsCategory({required this.title, required this.type, required this.profiles});

  @override
  Widget build(BuildContext context) {
    final filteredProfiles = profiles.where((profile) => profile.stateProfile == type).toList();

    if (filteredProfiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredProfiles.length,
          itemBuilder: (context, index) {
            return LockProfileCard(profile: filteredProfiles[index]);
          },
        ),
      ],
    );
  }
}