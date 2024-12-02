import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/enums/age.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/item_container.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class EditAvailableAgeScreen extends StatefulWidget {
  const EditAvailableAgeScreen({super.key, this.availableAge});

  final List<Age>? availableAge;

  @override
  State<EditAvailableAgeScreen> createState() => _EditAvailableAgeScreenState();
}

class _EditAvailableAgeScreenState extends State<EditAvailableAgeScreen> {
  late Map<Age, bool> availableAgeMap;

  @override
  void initState() {
    super.initState();
    availableAgeMap = {};
    availableAgeMap.addEntries(Age.values.map((p) => MapEntry(p, false)));

    if (widget.availableAge != null) {
      for (var age in widget.availableAge!) {
        availableAgeMap[age] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();
    List<Age> values = Age.values;
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "자신있는 연령"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SubTitleText(title: "자신있는 연령"),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (context, index) {
                Age age = values[index];
                bool isChecked = availableAgeMap[age]!;
                return ButtonBase(
                  onTap: () {
                    setState(() {
                      availableAgeMap[age] = !availableAgeMap[age]!;
                    });
                  },
                  child: ItemContainer(
                      child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            availableAgeMap[age] = !availableAgeMap[age]!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: [
                          Text(
                            age.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(age.description)
                        ],
                      )
                    ],
                  )),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 8,
              ),
            ),
            const Spacer(),
            StatusBuilder(
              statusNotifier: provider.editProfileStatus,
              idleBuilder: (context) => ButtonTemplate(
                  title: "제출하기",
                  onTap: () {
                    List<Age> selected = availableAgeMap.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();
                    TeacherProfileEditReq req = TeacherProfileEditReq()
                      ..availableAge = selected;
                    provider.editTeacherProfile(req).then((_) {
                      Navigator.pop(context);
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                    });
                  },
                  isEnable: true),
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
