import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBase(
                    onTap: () {
                      authProvider.testSignIn(MemberRole.parent).then((_) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const parent.MainScreen()),
                                (route) => false);
                      });
                    },
                    child: const Text("부모님 로그인")),
                const SizedBox(height: 16,),
                ButtonBase(onTap: () {
                  authProvider.testSignIn(MemberRole.teacher).then((_) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => const teacher.MainScreen()), (
                            route) => false);
                  });
                }, child: const Text("선생님 로그인"))
              ],
            )));
  }
}
