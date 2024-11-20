import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:slost_only1/data/sign_in_req.dart';
import 'package:slost_only1/enums/auth_service_provider.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/parent_screen/main_screen.dart' as parent;
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/teacher_screen/main_screen.dart' as teacher;
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/text_template.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  const EnterPhoneNumberScreen(
      {super.key, required this.memberRole, required this.token, required this.authServiceProvider});

  final MemberRole memberRole;

  final AuthServiceProvider authServiceProvider;


  final dynamic token;

  @override
  State<EnterPhoneNumberScreen> createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "휴대폰 번호"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubTitleText(title: "휴대폰 번호 입력"),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              onChange: (text) {
                setState(() {
                  phoneNumber = text;
                });
              },
            ),
            const Spacer(),
            ButtonTemplate(
                title: "제출하기",
                onTap: () {
                  SignInReq req = SignInReq(
                      phoneNumber, AuthServiceProvider.kakao, widget.token,
                      widget.memberRole);
                  AuthProvider().signInWithKakaoTalk(req).then((_) {
                    late Widget route;
                    if (widget.memberRole == MemberRole.parent) {
                      route = const parent.MainScreen();
                    } else {
                      route = const teacher.MainScreen();
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => route),
                            (route) => false);
                  });
                },
                isEnable: phoneNumber.isNotEmpty),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}
