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

  void toggleSelection(int index) {
    setState(() {
      filteredApps[index] = filteredApps[index].copyWith(
        selected: !filteredApps[index].selected,
      );
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
              initialChildSize: 0.6,
              minChildSize: 0.3,
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


                                  CustomSearchBar(onChanged: filterApps),


                                  const SizedBox(height: 16.0),


                                  ...filteredApps.map((app) {
                                    int index = filteredApps.indexOf(app);
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.memory(app.icon!),
                                      ),
                                      title: Text(app.name),
                                      trailing: Checkbox(
                                        value: app.selected,
                                        onChanged: (bool? value) {
                                          toggleSelection(index);
                                        },
                                      ),
                                      onTap: () => toggleSelection(index),
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

// Extensión para añadir la propiedad 'selected' a AppInfo
extension SelectableAppInfo on AppInfo {
  static final Map<String, bool> _selectedMap = {};

  bool get selected => _selectedMap[packageName] ?? false;
  set selected(bool value) => _selectedMap[packageName] = value;

  AppInfo copyWith({bool? selected}) {
    final newApp = AppInfo(
      name: name,
      packageName: packageName,
      versionName: versionName,
      versionCode: versionCode,
      icon: icon,
      builtWith: builtWith,
      installedTimestamp: installedTimestamp,
    );
    if (selected != null) {
      newApp.selected = selected;
    }
    return newApp;
  }
}