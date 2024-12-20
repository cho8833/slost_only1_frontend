import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/manage_dolbom_location_screen.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';
import 'package:slost_only1/parent_screen/create_dolbom/select_dolbom_schedule_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SelectDolbomLocationScreen extends StatefulWidget {
  const SelectDolbomLocationScreen({super.key,});

  @override
  State<SelectDolbomLocationScreen> createState() => _SelectDolbomLocationScreenState();
}

class _SelectDolbomLocationScreenState extends State<SelectDolbomLocationScreen> {

  late CreateDolbomContext createDolbomContext;
  bool isNextEnable = false;

  DolbomLocation? selected;

  @override
  Widget build(BuildContext context) {
    createDolbomContext = context.watch<CreateDolbomContext>();;
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
                createDolbomContext.dolbomLocation = selected;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: createDolbomContext,
                          child: const SelectDolbomScheduleScreen(
                          ),
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
