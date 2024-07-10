import 'package:flutter/material.dart';

class BlockedAppsIcons extends StatelessWidget {
  final List<String> appImageUrls;

  BlockedAppsIcons({required this.appImageUrls});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        appImageUrls.length > 5 ? 5 : appImageUrls.length,
        (index) {
          if (index == 4 && appImageUrls.length > 5) {
            return Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              child: Text(
                '+${appImageUrls.length - 4}',
                style: const TextStyle(fontSize: 12),
              ),
            );
          } else {
            return const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Placeholder(
                  fallbackHeight: 24,
                  fallbackWidth: 24,
                )
                // Image.network(
                //   appImageUrls[index],
                //   width: 24,
                //   height: 24,
                //   errorBuilder: (context, error, stackTrace) {
                //     return const Icon(Icons.error); // Muestra un ícono de error si la imagen no puede cargarse
                //   })
             );
          }
        },
      ),
    );
  }
}
