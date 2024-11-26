import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/teacher_profile/profile_image_circle.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class TeacherProfileDetail extends StatefulWidget {
  const TeacherProfileDetail({super.key, required this.teacherProfile});

  final TeacherProfile teacherProfile;

  @override
  State<TeacherProfileDetail> createState() => _TeacherProfileDetailState();
}

class _TeacherProfileDetailState extends State<TeacherProfileDetail> {
  late TeacherProfileProvider teacherProfileProvider;

  @override
  void initState() {
    teacherProfileProvider = context.read<TeacherProfileProvider>();
    teacherProfileProvider.getAvailableArea(widget.teacherProfile.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileImageCircle(imageUrl: widget.teacherProfile.profileImageUrl,),
        const SizedBox(height: 8,),

        const SubTitleText(title: "프로필 이름"),
        const SizedBox(
          height: 8,
        ),
        Text(widget.teacherProfile.profileName),
        const SizedBox(
          height: 16,
        ),
        const SubTitleText(title: "이름"),
        const SizedBox(
          height: 8,
        ),
        Text(widget.teacherProfile.name),
        const SizedBox(
          height: 16,
        ),
        const SubTitleText(title: "성별"),
        const SizedBox(
          height: 8,
        ),
        Text(widget.teacherProfile.gender.title),
        const SizedBox(
          height: 16,
        ),
        const SubTitleText(title: "생일"),
        const SizedBox(
          height: 8,
        ),
        Text(
            DateFormat("yyyy년 MM월 dd일").format(widget.teacherProfile.birthday)),
        const SizedBox(
          height: 16,
        ),
        const SubTitleText(title: "방문 지역"),
        const SizedBox(
          height: 8,
        ),
        StatusBuilder(
            statusNotifier: teacherProfileProvider.getAvailableAreaStatus,
            successBuilder: (context) => Text(teacherProfileProvider
                .availableAreas
                .map((area) => area.sigungu)
                .join(",")))
      ],
    );
  }
}
