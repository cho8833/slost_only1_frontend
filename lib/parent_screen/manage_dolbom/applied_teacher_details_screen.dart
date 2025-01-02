import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/provider/parent_dolbom_provider.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/teacher_profile/teacher_profile_detail.dart';
import 'package:status_builder/status_builder.dart';

class AppliedTeacherDetailsScreen extends StatefulWidget {
  const AppliedTeacherDetailsScreen(
      {super.key, required this.teacherProfile, required this.dolbom});

  final TeacherProfile teacherProfile;
  final Dolbom dolbom;

  @override
  State<AppliedTeacherDetailsScreen> createState() =>
      _AppliedTeacherDetailsScreenState();
}

class _AppliedTeacherDetailsScreenState
    extends State<AppliedTeacherDetailsScreen> {
  late ParentDolbomProvider dolbomProvider =
      context.read<ParentDolbomProvider>();

  void matchDolbom() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("매칭 확인"),
            content: Text("${widget.teacherProfile.name} 선생님으로 확정하시겠습니까?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "취소",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    dolbomProvider.matchDolbom(
                        widget.dolbom.id, widget.teacherProfile.id).then((_) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                    });
                  },
                  child: const Text("확인")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        appBarObj: AppBar(),
        title: "신청한 선생님",
        trailingBuilder: (context) => TextButton(
            onPressed: () {
              matchDolbom();
            },
            child: StatusBuilder(
                statusNotifier: dolbomProvider.matchDolbomStatus,
                idleBuilder: (context) {
                  return const Text("매칭 완료");
                })),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TeacherProfileDetail(teacherProfile: widget.teacherProfile),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
