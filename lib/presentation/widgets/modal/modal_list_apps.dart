import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/providers.dart';
import 'package:focustime/presentation/widgets/shared/bustom_search_bar.dart';
import 'package:installed_apps/app_info.dart';

import '../../providers/profiles/apps_installed_provider.dart';

class ListAppsModal extends ConsumerStatefulWidget {
  const ListAppsModal({super.key});

  @override
  _ListAppsModalState createState() => _ListAppsModalState();
}

class _ListAppsModalState extends ConsumerState<ListAppsModal> {
  List<AppInfo> filteredApps = [];
  Map<String, bool> selectionState = {};
  String searchQuery = '';

  void filterApps(String query) {
    setState(() {
      searchQuery = query;
    });
  }

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
        body: Center(
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.5,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: appsAsyncValue.when(
                    data: (apps) {
                      // Filtramos las apps aquí para que se actualice con cada cambio en searchQuery
                      filteredApps = apps
                          .where((app) => app.name.toLowerCase().contains(searchQuery.toLowerCase()))
                          .toList();
                      
                      // Inicializamos selectionState si está vacío
                      if (selectionState.isEmpty) {
                        selectionState = {for (var app in apps) app.packageName: false};
                      }

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomSearchBar(onChanged: filterApps),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.check),
                                  onPressed: () {
                                    final selectedApps = filteredApps
                                        .where((app) => selectionState[app.packageName] ?? false)
                                        .toList();
                                    ref.read(newLockProfileProvider.notifier).addApps(selectedApps);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: filteredApps.length,
                              itemBuilder: (context, index) {
                                final app = filteredApps[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.memory(app.icon!),
                                  ),
                                  title: Text(app.name),
                                  trailing: Checkbox(
                                    value: selectionState[app.packageName] ?? false,
                                    onChanged: (bool? value) => toggleSelection(app.packageName),
                                  ),
                                  onTap: () => toggleSelection(app.packageName),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text('Error: $error')),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}