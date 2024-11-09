import 'package:flutter/material.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_notice/create_dolbom_notice/create_dolbom_notice_context.dart';
import 'package:slost_only1/widget/dolbom_notice/create_dolbom_notice/select_dolbom_location_screen.dart';
import 'package:slost_only1/widget/kid/manage_kid_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SelectKidScreen extends StatefulWidget {
  const SelectKidScreen({super.key});

  @override
  State<SelectKidScreen> createState() => _SelectKidScreenState();
}

class _SelectKidScreenState extends State<SelectKidScreen> {
  bool isNextEnable = false;

  final CreateDolbomNoticeContext createContext = CreateDolbomNoticeContext();

  List<Kid> selected = [];

  void onKidSelected(Kid kid) {
    if (selected.contains(kid)) {
      selected.remove(kid);
    } else {
      selected.add(kid);
    }
    setState(() {
      isNextEnable = selected.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 신청하기"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "아이 정보",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("아이 정보를 선택해주세요"),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: KidList(
                onItemSelect: (kid) {
                  onKidSelected(kid);
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ButtonTemplate(
              title: "다음",
              isEnable: isNextEnable,
              onTap: () {
                createContext.kids = selected;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectDolbomLocationScreen(
                              createContext: createContext,
                            )));
              },
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}
