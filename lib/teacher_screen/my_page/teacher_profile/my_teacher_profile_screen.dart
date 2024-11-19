import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/teacher_screen/my_page/create_profile/create_profile_screen1.dart';
import 'package:slost_only1/widget/teacher_profile/teacher_profile_detail.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class MyTeacherProfileScreen extends StatefulWidget {
  const MyTeacherProfileScreen({super.key});

  @override
  State<MyTeacherProfileScreen> createState() => _MyTeacherProfileScreenState();
}

class _MyTeacherProfileScreenState extends State<MyTeacherProfileScreen> {
  late TeacherProfileProvider teacherProfileProvider;

  @override
  void initState() {
    teacherProfileProvider = context.read<TeacherProfileProvider>();
    teacherProfileProvider.getMyTeacherProfile().then((_) {
      if (teacherProfileProvider.teacherProfile != null) {
        teacherProfileProvider
            .getAvailableArea(teacherProfileProvider.teacherProfile!.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "내 프로필"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StatusBuilder(
          statusNotifier: teacherProfileProvider.getTeacherProfileStatus,
          successBuilder: (context) {
            if (teacherProfileProvider.teacherProfile == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTemplate(
                      title: "프로필 등록하기",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateProfileScreen1()));
                      },
                      isEnable: true),
                ],
              );
            } else {
              TeacherProfile teacherProfile =
                  teacherProfileProvider.teacherProfile!;
              return TeacherProfileDetail(teacherProfile: teacherProfile);
            }
          },
        ),
      ),
    );
  }
}
