import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slost_only1/data/auth_req.dart';
import 'package:slost_only1/enums/auth_service_provider.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/screen/privacy_screen.dart';
import 'package:slost_only1/screen/terms_screen.dart';
import 'package:slost_only1/teacher_screen/main_screen.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  AuthProvider authProvider = AuthProvider();

  void signIn(SignInReq req) {
    authProvider.signIn(req).then((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.8), BlendMode.dstATop),
              fit: BoxFit.fitHeight,
              image: const AssetImage(
                  "asset/teacher_login_screen_background_image.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SubPageAppBar(
          appBarObj: AppBar(),
          title: "",
          backgroundColor: Colors.transparent,
          buttonColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              ButtonBase(
                  onTap: () {
                    authProvider.kakaoOAuth().then((token) {
                      SignInReq req = SignInReq(AuthServiceProvider.kakao,
                          MemberRole.teacher, token, null);
                      signIn(req);
                    });
                  },
                  child: Image.asset("asset/kakao_login.png")),
              const SizedBox(
                height: 16,
              ),
              ButtonBase(
                  onTap: () {
                    authProvider.appleOAuth().then((credential) {
                      SignInReq req = SignInReq(AuthServiceProvider.apple,
                          MemberRole.teacher, null, credential);
                      signIn(req);
                    });
                  },
                  child: Image.asset("asset/apple_login.png")),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 16,),
                  ButtonBase(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (
                            context) => const TermsScreen()));
                      },
                      child: const Text(
                        "이용 약관",
                        style: TextStyle(color: Colors.white),
                      )),
                  ButtonBase(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => const PrivacyScreen()));
                  },
                      child: const Text("개인정보 이용 정책",
                        style: TextStyle(color: Colors.white),)),
                  const SizedBox(width: 16,),
                ],
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
