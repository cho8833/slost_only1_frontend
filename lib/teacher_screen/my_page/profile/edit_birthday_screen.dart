import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class EditBirthdayScreen extends StatefulWidget {
  const EditBirthdayScreen({super.key, this.birthday});

  final DateTime? birthday;

  @override
  State<EditBirthdayScreen> createState() => _EditBirthdayScreenState();
}

class _EditBirthdayScreenState extends State<EditBirthdayScreen> {
  DateTime? birthday;

  @override
  void initState() {
    super.initState();
    birthday = widget.birthday;
  }

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "생일"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SubTitleText(title: "생년월일"),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12)),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ButtonBase(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              firstDate: DateTime(2010),
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now())
                          .then((selectedDate) {
                        setState(() {
                          birthday = selectedDate;
                        });
                      });
                    },
                    child: Text(
                      birthday != null
                          ? DateFormat("yyyy년 MM월 dd일").format(birthday!)
                          : "날짜를 선택해주세요",
                      style: TextStyle(
                          color:
                              birthday != null ? Colors.black : Colors.black12),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            StatusBuilder(
              statusNotifier: provider.editProfileStatus,
              idleBuilder: (context) {
                return ButtonTemplate(title: "제출하기", onTap: () {
                  TeacherProfileEditReq req = TeacherProfileEditReq()
                  ..birthday = birthday;
                  provider.editTeacherProfile(req).then((_) {
                    Navigator.pop(context);
                  }).catchError((e) {
                    Fluttertoast.showToast(msg: e.toString());
                  });
                }, isEnable: birthday != null);
              }
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}
