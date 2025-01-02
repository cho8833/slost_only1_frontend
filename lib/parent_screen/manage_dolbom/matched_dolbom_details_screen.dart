import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/parent_screen/near_teacher/teacher_profile_detail_screen.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/teacher_profile/teacher_profile_card.dart';
import 'package:status_builder/status_builder.dart';

class MatchedDolbomDetailsScreen extends StatefulWidget {
  const MatchedDolbomDetailsScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<MatchedDolbomDetailsScreen> createState() =>
      _MatchedDolbomDetailsScreenState();
}

class _MatchedDolbomDetailsScreenState
    extends State<MatchedDolbomDetailsScreen> {
  late TeacherProfileProvider teacherProvider;

  @override
  void initState() {
    teacherProvider = context.read<TeacherProfileProvider>();
    teacherProvider.getByDolbomId(widget.dolbom.id);
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
              "선생님",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            StatusBuilder(
                statusNotifier: teacherProvider.getTeacherProfileStatus,
                successBuilder: (context) {
                  return TeacherProfileCard(
                    teacher: teacherProvider.teacherProfile,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              TeacherProfileDetailScreen(
                                  teacherProfile: teacherProvider
                                      .teacherProfile)));
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
