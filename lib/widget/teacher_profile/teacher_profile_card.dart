import 'package:flutter/material.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/widget/button_base.dart';

class TeacherProfileCard extends StatelessWidget {
  const TeacherProfileCard({super.key, required this.teacher, this.onTap});

  final TeacherProfile teacher;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.network(teacher.profileImageUrl),
            const SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teacher.profileName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}