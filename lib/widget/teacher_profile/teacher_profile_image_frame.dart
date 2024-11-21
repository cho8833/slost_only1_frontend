import 'package:flutter/material.dart';

class TeacherProfileImageFrame extends StatelessWidget {
  const TeacherProfileImageFrame({super.key, required this.child});

  final Widget child;

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
          child: child),
    );
  }
}
