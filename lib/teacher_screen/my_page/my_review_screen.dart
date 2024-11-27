import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/provider/dolbom_review_provider.dart';
import 'package:slost_only1/widget/infinite_scroll_list.dart';
import 'package:slost_only1/widget/review/dolbom_review_item.dart';
import 'package:slost_only1/widget/review/report_review_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class MyReviewScreen extends StatelessWidget {
  const MyReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DolbomReviewProvider provider = context.read<DolbomReviewProvider>();

    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "내 리뷰 관리"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: InfiniteScrollList(
                  pageRequest: (page) {
                    return provider.getMyReviews(page);
                  },
                  onMount: (controller) {},
                  itemBuilder: (ctx, item, index) {
                    return DolbomReviewItem(
                      dolbomReview: item,
                      dropdownItems: [
                        ReviewDropDownItem(title: "신고", onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportReviewScreen(review: item)));
                        })
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
