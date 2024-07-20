import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    // Asumiendo que colors es una lista de String

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                      title: "Modo Oscuro",
                      icon: Icons.dark_mode_outlined,
                      trailing: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            ref.read(themeProvider.notifier).changeTheme();
                          })),
                  const _CustomListTile(
                    title: "Cambiar colores - tema",
                    icon: Icons.color_lens_outlined,
                    trailing: _DropdownColors(),
                  ),
                  const _CustomListTile(
                      title: "Notifications",
                      icon: Icons.notifications_none_rounded),
                  const _CustomListTile(
                      title: "Security Status",
                      icon: Icons.security_outlined),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownColors extends ConsumerWidget {
  const _DropdownColors();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(colorListProvider);
    final currentColor = ref.watch(themeProvider).selectColor;
    
    return DropdownButton<int>(
      value: currentColor, // Asegúrate de que esto sea un índice (int)
      items: List.generate(colors.length, (index) {
        return DropdownMenuItem<int>(
          value: index,
          child: Container(
            decoration: BoxDecoration(
              color: colors[index],
              shape: BoxShape.circle,
            ),
            width: 20,
            height: 20,
          ),
        );
      }),
      onChanged: (int? newIndex) {
        ref.read(themeProvider.notifier).changeColor(newIndex!);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {required this.title, required this.icon, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}