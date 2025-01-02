import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/enums/review_report_reason.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/provider/dolbom_review_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class ReportReviewScreen extends StatefulWidget {
  const ReportReviewScreen({super.key, required this.review});

  final DolbomReview review;

  @override
  State<ReportReviewScreen> createState() => _ReportReviewScreenState();
}

class _ReportReviewScreenState extends State<ReportReviewScreen> {

  ReviewReportReason? reason;

  String? content;

  @override
  Widget build(BuildContext context) {
    DolbomReviewProvider provider = context.read<DolbomReviewProvider>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "리뷰 신고"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SubTitleText(title: "사유", required: true,),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownButton2(
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12),
                  borderRadius: BorderRadius.circular(8)
                )
              ),
              hint: const Text("사유를 선택해주세요"),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  reason = value;
                });
              },
                value: reason,
                items:
                    ReviewReportReason.values.map<DropdownMenuItem>((reason) {
              return DropdownMenuItem(value: reason, child: Text(reason.title));
            }).toList()),
            const SizedBox(height: 16,),
            const SubTitleText(title: "신고 내용"),
            const SizedBox(height: 8,),
            TextFieldTemplate(
              onChange: (text) {
                content = text;
              },
            ),
            const Spacer(),
            StatusBuilder(
              statusNotifier: provider.reportStatus,
              idleBuilder: (context) {
                return ButtonTemplate(title: "신고하기", onTap: () {
                  provider.reportReview(reason: reason!, content: content, reviewId: widget.review.id).then((e) {
                    Fluttertoast.showToast(msg: "신고가 접수되었습니다");
                    Navigator.pop(context);
                  }).catchError((e) {
                    Fluttertoast.showToast(msg: e.toString());
                  });
                }, isEnable: reason != null);
              }
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}
