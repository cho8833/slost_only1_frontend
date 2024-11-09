import 'package:flutter/material.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/manage_dolbom_location_screen.dart';
import 'package:slost_only1/widget/dolbom_notice/create_dolbom_notice/create_dolbom_notice_context.dart';
import 'package:slost_only1/widget/dolbom_notice/create_dolbom_notice/select_dolbom_schedule_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SelectDolbomLocationScreen extends StatefulWidget {
  const SelectDolbomLocationScreen({super.key, required this.createContext});

  final CreateDolbomNoticeContext createContext;
  @override
  State<SelectDolbomLocationScreen> createState() => _SelectDolbomLocationScreenState();
}

class _SelectDolbomLocationScreenState extends State<SelectDolbomLocationScreen> {

  bool isNextEnable = false;

  DolbomLocation? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 신청하기"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: DolbomLocationList(
              isMultiSelect: false,
              onSelect: (selectedList) {
                if (selectedList.isEmpty) {
                  selected = null;
                } else {
                  selected = selectedList[0];
                }
                setState(() {
                  isNextEnable = selected != null;
                });
              },
            )),
            ButtonTemplate(
              title: "다음",
              isEnable: isNextEnable,
              onTap: () {
                widget.createContext.dolbomLocation = selected;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectDolbomScheduleScreen(
                          createContext: widget.createContext,
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
