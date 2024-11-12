import 'package:flutter/material.dart';
import 'package:slost_only1/model/teacher_profile.dart';

class TeacherProfileCard extends StatelessWidget {
  const TeacherProfileCard({super.key, required this.teacher});

  final TeacherProfile teacher;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.network(teacher.profileImageUrl),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network("https://s.pstatic.net/static/www/mobile/edit/20241101_1095/upload_17304407629933y6Lu.png"),
              Text(teacher.profileName)
            ],
          ),
        ],
      ),
    );
  }
}