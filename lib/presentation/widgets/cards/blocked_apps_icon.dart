import 'dart:typed_data';
import 'package:flutter/material.dart';

class BlockedAppsIcons extends StatelessWidget {
  final List<Uint8List?> appIcons;
  final double width;
  final double height;
  final int limit;

  const BlockedAppsIcons({
    super.key,
    required this.appIcons,
    this.width = 24,
    this.height = 24,
    this.limit = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.0, // Espacio vertical entre filas
      children: List.generate(
        appIcons.length > limit + 1 ? limit + 1 : appIcons.length,
        (index) {
          if (index == limit) {
            return Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              child: Text(
                '+${appIcons.length - limit}',
                style: const TextStyle(fontSize: 12),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: appIcons[index] == null
                  ? const Icon(Icons.question_mark_outlined)
                  : Image.memory(
                      appIcons[index]!,
                      width: width,
                      height: height,
                    ),
            );
          }
        },
      ),
    );
  }
}
