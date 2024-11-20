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

class EditIntroduceScreen extends StatefulWidget {
  const EditIntroduceScreen({super.key, required this.introduce});

  final String? introduce;

  @override
  State<EditIntroduceScreen> createState() => _EditIntroduceScreenState();
}

class _EditIntroduceScreenState extends State<EditIntroduceScreen> {
  late String introduce;

  @override
  void initState() {
    super.initState();
    introduce = widget.introduce ?? "";
  }

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "한 문장 자기소개"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubTitleText(title: "한 문장 자기소개"),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              initValue: introduce,
              onChange: (text) {
                introduce = text;
              },
            ),
            const Spacer(),
            StatusBuilder(
                statusNotifier: provider.editProfileStatus,
                idleBuilder: (context) {
                  return ButtonTemplate(
                      title: "제출하기",
                      onTap: () {
                        TeacherProfileEditReq req = TeacherProfileEditReq();
                        req.introduce = introduce;
                        provider.editTeacherProfile(req).then((_) {
                          Navigator.pop(context);
                        }).catchError((e) {
                          Fluttertoast.showToast(msg: e.toString());
                        });
                      },
                      isEnable: true);
                }),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}
