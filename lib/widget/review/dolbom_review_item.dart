import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/provider/dolbom_review_provider.dart';
import 'package:slost_only1/widget/item_container.dart';
import 'package:slost_only1/widget/rating_star.dart';

class DolbomReviewItem extends StatelessWidget {
  const DolbomReviewItem(
      {super.key, required this.dolbomReview, this.dropdownItems});

  final DolbomReview dolbomReview;

  final List<ReviewDropDownItem>? dropdownItems;

  @override
  Widget build(BuildContext context) {
    DolbomReviewProvider provider = context.read<DolbomReviewProvider>();
    return ItemContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingStar(
              rating: provider.denormalizeRating(dolbomReview.star),
            ),
            dropdownItems != null
                ? DropdownButton2(
                    onChanged: (value) {
                      dropdownItems!.where((item) => value == item).first.onTap();
                    },
                    dropdownStyleData: const DropdownStyleData(
                      width: 100,
                    ),
                    customButton: const Icon(Icons.more_vert),
                    items: dropdownItems!.map<DropdownMenuItem>((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.title),
                      );
                    }).toList())
                : Container()
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(dolbomReview.content.isNotEmpty ? dolbomReview.content : "내용 없음")
      ],
    ));
  }
}

class ReviewDropDownItem {
  final String title;
  final void Function() onTap;

  ReviewDropDownItem({required this.title, required this.onTap});
}
