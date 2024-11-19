import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/provider/dolbom_review_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';
import 'package:slost_only1/widget/review/create_dolbom_review_screen.dart';
import 'package:slost_only1/widget/review/dolbom_review_item.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class DoneDolbomDetailsScreen extends StatefulWidget {
  const DoneDolbomDetailsScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<DoneDolbomDetailsScreen> createState() =>
      _DoneDolbomDetailsScreenState();
}

class _DoneDolbomDetailsScreenState extends State<DoneDolbomDetailsScreen> {
  late DolbomReviewProvider reviewProvider;

  @override
  void initState() {
    reviewProvider = context.read<DolbomReviewProvider>();
    reviewProvider.getReview(widget.dolbom.id);
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
            StatusBuilder(
                statusNotifier: reviewProvider.getDolbomReviewStatus,
              successBuilder: (context) {
                  DolbomReview? review = reviewProvider.dolbomReview;
                  if (review == null) {
                    return ButtonTemplate(
                        title: "리뷰 작성하기",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateDolbomReviewScreen(dolbom: widget.dolbom,)));
                        },
                        isEnable: true);
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
