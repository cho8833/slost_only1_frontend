import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}
