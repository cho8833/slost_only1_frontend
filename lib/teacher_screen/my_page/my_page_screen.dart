import 'package:flutter/material.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/screen/announcement_screen.dart';
import 'package:slost_only1/screen/faq_screen.dart';
import 'package:slost_only1/screen/login_screen.dart';
import 'package:slost_only1/screen/policy_screen.dart';
import 'package:slost_only1/teacher_screen/my_page/my_review_screen.dart';
import 'package:slost_only1/teacher_screen/my_page/profile/edit_profile_screen.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/teacher_screen/my_page/profile/certificate/manage_certificate_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
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
                  me == null ? "로그인 해주세요" : "선생님",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
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
                      builder: (context) => const EditProfileScreen()))),
          Menu(
              title: "자격증 관리",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManageCertificateScreen()));
              },
              icon: const Icon(Icons.badge_outlined)),
          Menu(
              title: "리뷰 관리",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyReviewScreen()));
              },
              icon: const Icon(Icons.reviews_outlined)),
          const SizedBox(
            height: 8,
          ),
          Menu(
              title: "공지사항",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnnouncementScreen()));
              },
              icon: const Icon(Icons.info_outline)),
          Menu(
              title: "자주 묻는 질문",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FAQScreen())),
              icon: const Icon(Icons.help_outline)),
          Menu(
              title: "서비스 이용 정책",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PolicyScreen())),
              icon: Container()),
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
