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

class EditHowBecameTeacherScreen extends StatefulWidget {
  const EditHowBecameTeacherScreen({super.key, required this.howBecameTeacher});

  final String? howBecameTeacher;

  @override
  State<EditHowBecameTeacherScreen> createState() =>
      _EditHowBecameTeacherScreenState();
}

class _EditHowBecameTeacherScreenState
    extends State<EditHowBecameTeacherScreen> {
  late String howBecameTeacher;

  @override
  void initState() {
    super.initState();
    howBecameTeacher = widget.howBecameTeacher ?? "";
  }

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "선생님이 된 계기"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubTitleText(title: "선생님이 된 계기"),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              initValue: howBecameTeacher,
              hint: "선생님이 된 계기를 입력해주세요",
              onChange: (text) {
                howBecameTeacher = text;
              },
            ),
            const Spacer(),
            StatusBuilder(
              statusNotifier: provider.editProfileStatus,
              idleBuilder: (context) => ButtonTemplate(
                  title: "제출하기",
                  onTap: () {
                    TeacherProfileEditReq req = TeacherProfileEditReq()
                      ..howBecameTeacher = howBecameTeacher;
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
