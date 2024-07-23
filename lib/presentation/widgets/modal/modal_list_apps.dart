import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/providers.dart';

class ListAppsModal extends ConsumerStatefulWidget {
  const ListAppsModal({super.key});

  @override
  _ListAppsModalState createState() => _ListAppsModalState();
}

class _ListAppsModalState extends ConsumerState<ListAppsModal> {
  List<Map<String, dynamic>> apps = [
    {'name': 'App 1', 'icon': Icons.apps, 'selected': false},
    {'name': 'App 2', 'icon': Icons.apps, 'selected': false},
    {'name': 'App 3', 'icon': Icons.apps, 'selected': false},
    // Add more apps here
  ];
  List<Map<String, dynamic>> filteredApps = [];

  @override
  void initState() {
    super.initState();
    filteredApps = apps;
  }

  void filterApps(String query) {
    setState(() {
      filteredApps = apps
          .where(
              (app) => app['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleSelection(int index) {
    setState(() {
      filteredApps[index]['selected'] = !filteredApps[index]['selected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;

    //Este GestureDetector detecta los toques fuera del modal y cierra el modal con Navigator.of(context).pop().
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      //Esto se hace para permitir que los toques pasen a través de él.
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          //Este GestureDetector captura los toques dentro del modal, evitando que el GestureDetector externo cierre el modal.
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
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchBar(onChanged: filterApps),
                            const SizedBox(height: 16.0),
                            ...filteredApps.map((app) {
                              int index = filteredApps.indexOf(app);
                              return ListTile(
                                leading: Icon(app['icon']),
                                title: Text(app['name']),
                                trailing: Checkbox(
                                  value: app['selected'],
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

class SearchBar extends ConsumerStatefulWidget {
  final Function(String) onChanged;

  const SearchBar({required this.onChanged, super.key});

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar>
    with SingleTickerProviderStateMixin {
  bool _isActive = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;

    return Row(
      children: [
        if (!_isActive)
          const Text(
            "Seleccione las aplicaciones a bloquear",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

        
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: _isActive
                  ? Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[900] : Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Search for something',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                                _isActive = false;
                                widget.onChanged('');
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        onChanged: widget.onChanged,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _isActive = true;
                        });
                      },
                      icon: const Icon(Icons.search),
                    ),
            ),
          ),
        ),

        IconButton(onPressed: () {Navigator.of(context).pop();}, icon: const Icon(Icons.check)),

      ],
    );
  }
}
