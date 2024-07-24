import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/providers.dart';
import 'package:focustime/presentation/widgets/shared/bustom_search_bar.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class ListAppsModal extends ConsumerStatefulWidget {
  const ListAppsModal({super.key});

  @override
  _ListAppsModalState createState() => _ListAppsModalState();
}

class _ListAppsModalState extends ConsumerState<ListAppsModal> {
  List<AppInfo> apps = [];
  List<AppInfo> filteredApps = [];
  Map<String, bool> selectionState = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadApps();
  }

  Future<void> loadApps() async {
    final installedApps = await InstalledApps.getInstalledApps(true, true);
    setState(() {
      apps = installedApps;
      filteredApps = installedApps;
      // Inicializar el estado de selección
      selectionState = {for (var app in apps) app.packageName: false};
      isLoading = false;
    });
  }

  void filterApps(String query) {
    setState(() {
      filteredApps = apps
          .where((app) => app.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
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

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
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
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          controller: scrollController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomSearchBar(
                                            onChanged: filterApps),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.check),
                                        onPressed: () {
                                          final selectedApps = filteredApps
                                              .where((app) =>
                                                  selectionState[
                                                      app.packageName] ??
                                                  false)
                                              .toList();

                                          ref
                                              .read(newLockProfileProvider
                                                  .notifier)
                                              .addApps(selectedApps);

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  ...filteredApps.map((app) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.memory(app.icon!),
                                      ),
                                      title: Text(app.name),
                                      trailing: Checkbox(
                                        value:
                                            selectionState[app.packageName] ??
                                                false,
                                        onChanged: (bool? value) {
                                          toggleSelection(app.packageName);
                                        },
                                      ),
                                      onTap: () =>
                                          toggleSelection(app.packageName),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
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
