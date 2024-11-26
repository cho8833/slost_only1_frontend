import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/infinite_scroll_list.dart';
import 'package:slost_only1/widget/review/dolbom_review_item.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/teacher_profile/teacher_profile_detail.dart';
import 'package:slost_only1/widget/text_template.dart';

class TeacherProfileDetailScreen extends StatefulWidget {
  const TeacherProfileDetailScreen({super.key, required this.teacherProfile});

  final TeacherProfile teacherProfile;

  @override
  State<TeacherProfileDetailScreen> createState() =>
      _TeacherProfileDetailScreenState();
}

class _TeacherProfileDetailScreenState
    extends State<TeacherProfileDetailScreen> {

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    return Scaffold(
        appBar: SubPageAppBar(
            appBarObj: AppBar(), title: widget.teacherProfile.profileName),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeacherProfileDetail(teacherProfile: widget.teacherProfile),
                const SizedBox(height: 8,),
                const SubTitleText(title: "리뷰"),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 300,
                  child: InfiniteScrollList<DolbomReview>(
                      pageRequest: (page) {
                        return provider.getTeacherReview(widget.teacherProfile.id, page);
                      },
                      onMount: (controller) {},
                      itemBuilder: (context, item, index) {
                        return DolbomReviewItem(dolbomReview: item);
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
