import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/provider/dolbom_review_provider.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';
import 'package:slost_only1/widget/review/dolbom_review_item.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class DoneDolbomDetailScreen extends StatefulWidget {
  const DoneDolbomDetailScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<DoneDolbomDetailScreen> createState() => _DoneDolbomDetailScreenState();
}

class _DoneDolbomDetailScreenState extends State<DoneDolbomDetailScreen> {

  late DolbomReviewProvider reviewProvider;

  @override
  void initState() {
    super.initState();
    reviewProvider = context.read<DolbomReviewProvider>();
    reviewProvider.getReview(widget.dolbom.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 상세"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DolbomDetail(dolbom: widget.dolbom),
            const SizedBox(height: 16,),
            const SubTitleText(title: "등록된 리뷰"),
            StatusBuilder(
              statusNotifier: reviewProvider.getDolbomReviewStatus,
              successBuilder: (context) {
                DolbomReview? review = reviewProvider.dolbomReview;
                if (review == null) {
                  return const Text("등록된 리뷰가 없습니다");
                } else {
                  return DolbomReviewItem(dolbomReview: review);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
