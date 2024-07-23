import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/presentation/providers/theme/theme_providers.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  final Function(String) onChanged;

  const CustomSearchBar({required this.onChanged, super.key});

  @override
  ConsumerState<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<CustomSearchBar>
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
            "Aplicaciones para bloquear",
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
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
