import 'package:flutter/material.dart';

class DogImageCard extends StatelessWidget {
  final String imageUrl;

  const DogImageCard(
    this.imageUrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (_, __, ___) {
          return const Center(
              child: Text(
            'Impossible to load image',
            textAlign: TextAlign.center,
          ));
        },
      ),
    );
  }
}
