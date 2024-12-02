import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/enums/dolbom_category.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class EditAvailableCategoryScreen extends StatefulWidget {
  const EditAvailableCategoryScreen({super.key, this.availableCategory});

  final List<DolbomCategory>? availableCategory;

  @override
  State<EditAvailableCategoryScreen> createState() =>
      _EditAvailableCategoryScreenState();
}

class _EditAvailableCategoryScreenState
    extends State<EditAvailableCategoryScreen> {
  late Map<DolbomCategory, bool> categoryMap;

  @override
  void initState() {
    super.initState();
    categoryMap = {};
    categoryMap
        .addEntries(DolbomCategory.values.map((p) => MapEntry(p, false)));

    if (widget.availableCategory != null) {
      for (var category in widget.availableCategory!) {
        categoryMap[category] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "자신있는 수업"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SubTitleText(title: "자신있는 수업"),
            const SizedBox(
              height: 8,
            ),
            Wrap(
                children: categoryMap.entries.map<Widget>((entry) {
              DolbomCategory category = entry.key;
              bool isSelected = entry.value;
              return ButtonBase(
                onTap: () {
                  setState(() {
                    categoryMap[category] = !categoryMap[category]!;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          width: 1,
                          color:
                              isSelected ? Colors.blueAccent : Colors.black12),
                      color:
                          isSelected ? Colors.blueAccent : Colors.transparent),
                  child: Text(
                    category.title,
                    style: TextStyle(color: isSelected ? Colors.white : null),
                  ),
                ),
              );
            }).toList()),
            const Spacer(),
            StatusBuilder(
              statusNotifier: provider.editProfileStatus,
              idleBuilder: (context) => ButtonTemplate(
                  title: "제출하기",
                  onTap: () {
                    List<DolbomCategory> selected = categoryMap.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();
                    TeacherProfileEditReq req = TeacherProfileEditReq()
                      ..availableCategory = selected;
                    provider.editTeacherProfile(req).then((_) {
                      Navigator.pop(context);
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                    });
                  },
                  isEnable: true),
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}
