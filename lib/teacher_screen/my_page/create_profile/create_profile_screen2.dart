import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/data/available_area_req.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/select_address_modal.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/teacher_screen/my_page/teacher_profile/my_teacher_profile_screen.dart';
import 'package:status_builder/status_builder.dart';

class CreateProfileScreen2 extends StatefulWidget {
  const CreateProfileScreen2({super.key, required this.req});

  final TeacherProfileCreateReq req;

  @override
  State<CreateProfileScreen2> createState() => _CreateProfileScreen2State();
}

class _CreateProfileScreen2State extends State<CreateProfileScreen2> {
  late TeacherProfileProvider provider;

  @override
  void initState() {
    provider = context.read<TeacherProfileProvider>();
    super.initState();
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  String addressString(List<AvailableAreaCreateReq> req) {
    return req.map((r) => r.sigungu).join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "강사 프로필 등록"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText("예상 금액"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldTemplate(
                    onChange: (text) {
                      setState(() {
                        widget.req.pay = int.parse(text);
                      });
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: 8),
                const Text("원")
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            ButtonBase(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectAddressModal(
                          multiSelect: true,
                        )).then((selected) {
                  setState(() {
                    widget.req.availableArea =
                        (selected as List<SelectedSigungu>)
                            .map((s) => AvailableAreaCreateReq.from(s))
                            .toList();
                  });
                });
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(widget.req.availableArea.isNotEmpty
                    ? addressString(widget.req.availableArea)
                    : "주소를 선택해주세요"),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            StatusBuilder(
                statusNotifier: provider.createProfileStatus,
                idleBuilder: (context) {
                  return ButtonTemplate(
                      title: "등록하기",
                      onTap: () {
                        provider.createProfile(widget.req).then((_) {
                          Navigator.of(context).popUntil((route) =>
                          route is MaterialPageRoute &&
                              route.builder(context) is MyTeacherProfileScreen);
                        }).catchError((e) {
                          Fluttertoast.showToast(msg: e.toString());
                        });
                      },
                      isEnable: widget.req.validateSecond());
                })
          ],
        ),
      ),
    );
  }
}
