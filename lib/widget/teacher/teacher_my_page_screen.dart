import 'package:flutter/material.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/widget/auth/login_screen.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/manage_dolbom_location_screen.dart';
import 'package:slost_only1/widget/kid/manage_kid_screen.dart';
import 'package:slost_only1/widget/teacher/my_teacher_profile_screen.dart';

class TeacherMyPageScreen extends StatefulWidget {
  const TeacherMyPageScreen({super.key});

  @override
  State<TeacherMyPageScreen> createState() => _TeacherMyPageScreenState();
}

class _TeacherMyPageScreenState extends State<TeacherMyPageScreen> {
  AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    Member? me = authProvider.me;

    return Scaffold(
      appBar: AppBarBase(
        appBarObj: AppBar(),
        centerBuilder: (context) => const Text("마이 페이지",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  me == null
                      ? "로그인 해주세요" : "선생님",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                me == null ? Container() : Text(me.phoneNumber)
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Menu(
              icon: const Icon(Icons.person_outline),
              title: "프로필 정보",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyTeacherProfileScreen()))),
          const Spacer(),
          ButtonBase(
              onTap: () {
                authProvider.signOut().then((_) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                          (route) => false);
                });
              },
              child: const Text(
                "로그아웃",
                style: TextStyle(fontSize: 16, color: Colors.red),
              )),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu(
      {super.key,
        required this.title,
        required this.onTap,
        required this.icon});

  final String title;

  final void Function() onTap;

  final Widget icon;

  static const TextStyle menuTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonBase(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      icon,
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        title,
                        style: menuTitleStyle,
                      )
                    ],
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          ],
        ));
  }
}
