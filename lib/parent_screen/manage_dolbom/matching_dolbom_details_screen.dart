import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/parent_screen/manage_dolbom/applied_teacher_details_screen.dart';
import 'package:slost_only1/provider/parent_dolbom_provider.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/teacher_profile/teacher_profile_card.dart';
import 'package:status_builder/status_builder.dart';

class MatchingDolbomDetailScreen extends StatefulWidget {
  const MatchingDolbomDetailScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<MatchingDolbomDetailScreen> createState() =>
      _MatchingDolbomDetailScreenState();
}

class _MatchingDolbomDetailScreenState
    extends State<MatchingDolbomDetailScreen> {
  late ParentDolbomProvider dolbomProvider;

  @override
  void initState() {
    dolbomProvider = context.read<ParentDolbomProvider>();
    dolbomProvider.getAppliedTeacher(widget.dolbom.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 상세"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DolbomDetail(dolbom: widget.dolbom),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "신청한 선생님",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            StatusBuilder(
                statusNotifier: dolbomProvider.getPendingTeacherStatus,
                successBuilder: (context) {
                  List<TeacherProfile> teachers =
                      dolbomProvider.pendingTeachers;
                  if (teachers.isEmpty) {
                    return const Center(
                      child: Text("신청한 선생님이 없어요"),
                    );
                  } else {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          TeacherProfile teacher = teachers[index];
                          return TeacherProfileCard(teacher: teacher, onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppliedTeacherDetailsScreen(
                                          dolbom: widget.dolbom,
                                          teacherProfile: teacher,
                                        )));
                          },);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: dolbomProvider.pendingTeachers.length);
                  }
                })
          ],
        ),
      ),
    );
  }
}
