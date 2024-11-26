import 'package:flutter/material.dart';

class ProfileImageCircle extends StatelessWidget {
  const ProfileImageCircle({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
            width: 72,
            height: 72,
            child: Image.network(
              imageUrl,
              fit: BoxFit.fitHeight,
            )));
  }
}
