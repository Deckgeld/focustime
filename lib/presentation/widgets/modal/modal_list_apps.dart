import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/profiles/apps_installed_provider.dart';
import 'package:focustime/presentation/providers/providers.dart';
import 'package:focustime/presentation/widgets/shared/custom_search_bar.dart';
import 'package:installed_apps/app_info.dart';

class ListAppsModal extends ConsumerStatefulWidget {
  const ListAppsModal({super.key});

  @override
  ConsumerState<ListAppsModal> createState() => _ListAppsModalState();
}

class _ListAppsModalState extends ConsumerState<ListAppsModal> {
  Map<String, bool> selectionState = {}; // Inicialización vacía
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Inicializa el estado de selección con las aplicaciones seleccionadas, cuando el widget se ha construido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSelectionState();
    });
  }

  void _initializeSelectionState() {
    final currentProfile = ref.read(newLockProfileProvider);
    final selectedApps = currentProfile.apps;
    setState(() {
      selectionState = {
        for (var app in selectedApps) app.packageName: true,
      };
    });
  }

  void filterApps(String query) => setState(() => searchQuery = query);

  void toggleSelection(String packageName) {
    setState(() {
      selectionState[packageName] = !(selectionState[packageName] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    final appsAsyncValue = ref.watch(appsInstalledProvider);

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.8,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: appsAsyncValue.when(
              data: (apps) => _buildAppList(apps, scrollController),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppList(List<AppInfo> apps, ScrollController scrollController) {
    for (var app in apps) {
      selectionState.putIfAbsent(app.packageName, () => false);
    }

    final filteredApps = apps
        .where((app) => app.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(child: CustomSearchBar(onChanged: filterApps)),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () => _saveAndClose(apps),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: filteredApps.length,
            itemBuilder: (context, index) => _buildAppListTile(filteredApps[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildAppListTile(AppInfo app) => ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Image.memory(app.icon!),
    ),
    title: Text(app.name),
    trailing: Checkbox(
      value: selectionState[app.packageName] ?? false,
      onChanged: (_) => toggleSelection(app.packageName),
    ),
    onTap: () => toggleSelection(app.packageName),
  );

  void _saveAndClose(List<AppInfo> apps) {
    final selectedApps = apps.where((app) => selectionState[app.packageName] ?? false).toList();
    ref.read(newLockProfileProvider.notifier).addApps(selectedApps);
    Navigator.of(context).pop();
  }
}
