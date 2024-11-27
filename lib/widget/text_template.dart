import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({super.key, required this.title, this.required=false});

  final String title;

  final bool required;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        required ? const Text("*", style: TextStyle(fontSize: 20, color: Colors.red),) : Container()
      ],
    );
  }
}
