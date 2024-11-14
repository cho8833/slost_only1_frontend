import 'package:flutter/material.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';

class DoneDolbomDetailScreen extends StatelessWidget {
  const DoneDolbomDetailScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 상세"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DolbomDetail(dolbom: dolbom),
            const SizedBox(height: 16,),
            const SubTitleText(title: "등록된 리뷰"),
            
          ],
        ),
      ),
    );
  }
}
