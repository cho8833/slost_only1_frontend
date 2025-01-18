import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slost_only1/data/auth_req.dart';
import 'package:slost_only1/enums/auth_service_provider.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/screen/privacy_screen.dart';
import 'package:slost_only1/screen/terms_screen.dart';
import 'package:slost_only1/screen/teacher_login_screen.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/parent_screen/main_screen.dart' as parent;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider authProvider = AuthProvider();

  void signIn(SignInReq req) {
    authProvider.signIn(req).then((_) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const parent.MainScreen()));
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                      'asset/login_screen_background_image.jpeg'))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) => const TeacherLoginScreen()));
                          },
                          child: const Text("선생님으로 로그인")),
                    ),
                    // ButtonBase(
                    //     onTap: () {
                    //       authProvider.testSignIn(MemberRole.parent).then((_) {
                    //         Navigator.pushAndRemoveUntil(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const parent.MainScreen()),
                    //             (route) => false);
                    //       });
                    //     },
                    //     child: const Text("부모님 로그인")),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // ButtonBase(
                    //     onTap: () {
                    //       authProvider.testSignIn(MemberRole.teacher).then((_) {
                    //         Navigator.pushAndRemoveUntil(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const teacher.MainScreen()),
                    //             (route) => false);
                    //       });
                    //     },
                    //     child: const Text("선생님 로그인")),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    const Spacer(),
                    ButtonBase(
                        onTap: () {
                          authProvider.kakaoOAuth().then((token) {
                            SignInReq req = SignInReq(AuthServiceProvider.kakao,
                                MemberRole.parent, token, null);
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
                                MemberRole.parent, null, credential);
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
                    ),
                  ],
                )),
          ),
        ));
  }
}
