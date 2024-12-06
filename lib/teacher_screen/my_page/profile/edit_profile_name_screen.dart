import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class EditProfileNameScreen extends StatefulWidget {
  const EditProfileNameScreen({super.key, this.profileName});

  final String? profileName;
  @override
  State<EditProfileNameScreen> createState() => _EditProfileNameScreenState();
}

class _EditProfileNameScreenState extends State<EditProfileNameScreen> {

  String? profileName;

  @override
  void initState() {
    super.initState();
    profileName = widget.profileName;
  }
  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "프로필 이름"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubTitleText(title: "프로필 이름"),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              initValue: profileName,
              hint: "프로필 이름을 입력해주세요",
              onChange: (text) {
                profileName = text;
              },
            ),
            const Spacer(),
            StatusBuilder(
              statusNotifier: provider.editProfileStatus,
              idleBuilder: (context) => ButtonTemplate(
                  title: "제출하기",
                  onTap: () {
                    TeacherProfileEditReq req = TeacherProfileEditReq()
                      ..profileName = profileName;
                    provider.editTeacherProfile(req).then((_) {
                      Navigator.pop(context);
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                    });
                  },
                  isEnable: true),
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}
