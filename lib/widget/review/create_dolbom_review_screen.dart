import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/provider/dolbom_review_provider.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/rating_star.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class CreateDolbomReviewScreen extends StatefulWidget {
  const CreateDolbomReviewScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<CreateDolbomReviewScreen> createState() =>
      _CreateDolbomReviewScreenState();
}

class _CreateDolbomReviewScreenState extends State<CreateDolbomReviewScreen> {
  late DolbomReviewProvider dolbomReviewProvider;

  double star = 0;

  String content = "";

  @override
  void initState() {
    dolbomReviewProvider = context.read<DolbomReviewProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 리뷰 작성"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SubTitleText(
                  title: "평점",
                ),
                Text(
                  "*",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            RatingStar(
              minValue: 1,
              size: 50,
              rating: star,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              allowHalfRating: true,
              borderColor: Colors.black12,
              color: Colors.orange,
              onRatingChanged: (rating) {
                setState(() {
                  star = rating;
                });
              },
            ),
            const SizedBox(
              height: 32,
            ),
            const SubTitleText(title: "내용"),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              onChange: (text) {
                content = text;
              },
            ),
            const SizedBox(
              height: 32,
            ),
            StatusBuilder(
              statusNotifier: dolbomReviewProvider.addReviewStatus,
              idleBuilder: (context) => ButtonTemplate(
                  title: "작성하기",
                  onTap: () {
                    dolbomReviewProvider
                        .addReview(widget.dolbom.id, star, content)
                        .then((result) {
                      Navigator.pop(context);
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                    });
                  },
                  isEnable: true),
            ),
          ],
        ),
      ),
    );
  }
}
