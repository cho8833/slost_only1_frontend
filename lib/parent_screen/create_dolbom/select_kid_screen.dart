import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';
import 'package:slost_only1/parent_screen/create_dolbom/select_dolbom_location_screen.dart';
import 'package:slost_only1/widget/kid/manage_kid_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SelectKidScreen extends StatefulWidget {
  const SelectKidScreen({super.key});

  @override
  State<SelectKidScreen> createState() => _SelectKidScreenState();
}

class _SelectKidScreenState extends State<SelectKidScreen> {
  late CreateDolbomContext createDolbomContext;

  @override
  void initState() {
    super.initState();
  }

  bool isNextEnable = false;

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
    createDolbomContext = context.watch<CreateDolbomContext>();
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
                createDolbomContext.kids = selected;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: createDolbomContext,
                            child: const SelectDolbomLocationScreen())));
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
