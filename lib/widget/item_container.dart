import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
