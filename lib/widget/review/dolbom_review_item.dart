import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/provider/dolbom_review_provider.dart';
import 'package:slost_only1/widget/item_container.dart';
import 'package:slost_only1/widget/rating_star.dart';

class DolbomReviewItem extends StatelessWidget {
  const DolbomReviewItem({super.key, required this.dolbomReview});

  final DolbomReview dolbomReview;

  @override
  Widget build(BuildContext context) {
    DolbomReviewProvider provider = context.read<DolbomReviewProvider>();
    return ItemContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingStar(
          rating: provider.denormalizeRating(dolbomReview.star),
        ),
        const SizedBox(height: 8,),
        Text(dolbomReview.content.isNotEmpty ? dolbomReview.content : "내용 없음")
      ],
    ));
  }
}
