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

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({super.key, required this.name});

  final String? name;

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  late String name;

  @override
  void initState() {
    super.initState();
    name = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "이름"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubTitleText(title: "이름"),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              initValue: name,
              onChange: (text) {
                name = text;
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
                        req.name = name;
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
