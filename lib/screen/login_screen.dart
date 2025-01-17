import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slost_only1/data/auth_req.dart';
import 'package:slost_only1/enums/auth_service_provider.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/parent_screen/main_screen.dart' as parent;
import 'package:slost_only1/teacher_screen/main_screen.dart' as teacher;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider authProvider = AuthProvider();

  void signIn(SignInReq req) {
    authProvider.signIn(req).then((_) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const parent.MainScreen()));
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBase(
                      onTap: () {
                        authProvider.testSignIn(MemberRole.parent).then((_) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const parent.MainScreen()),
                                  (route) => false);
                        });
                      },
                      child: const Text("부모님 로그인")),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonBase(
                      onTap: () {
                        authProvider.testSignIn(MemberRole.teacher).then((_) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const teacher.MainScreen()),
                                  (route) => false);
                        });
                      },
                      child: const Text("선생님 로그인")),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonBase(
                      onTap: () {
                        authProvider.kakaoOAuth().then((token) {
                          SignInReq req = SignInReq(
                              AuthServiceProvider.kakao, MemberRole.parent,
                              token, null);
                          signIn(req);
                        });
                      },
                      child: Image.asset("asset/kakao_login.png")),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonBase(onTap: () {
                    authProvider.appleOAuth().then((credential) {
                      SignInReq req = SignInReq(
                          AuthServiceProvider.apple, MemberRole.parent, null,
                          credential);
                      signIn(req);
                    });
                  }, child: Image.asset("asset/apple_login.png"))
                ],
              )),
        ));
  }
}
