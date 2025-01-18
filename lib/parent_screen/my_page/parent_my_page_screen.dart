import 'package:flutter/material.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/screen/faq_screen.dart';
import 'package:slost_only1/screen/login_screen.dart';
import 'package:slost_only1/screen/announcement_screen.dart';
import 'package:slost_only1/screen/privacy_screen.dart';
import 'package:slost_only1/screen/terms_screen.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/manage_dolbom_location_screen.dart';
import 'package:slost_only1/parent_screen/my_page/kid/manage_kid_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  AuthProvider authProvider = AuthProvider();

  void showWithDrawlDialog() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: Text("회원탈퇴"),
          content: Text("정말로 회원탈퇴하시겠습니까?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
                child: Text("취소", style: TextStyle(color: Colors.red),)),
            TextButton(onPressed: () =>
                authProvider.withdrawal().then((_) =>
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) => LoginScreen()), (p) => false)),
                child: Text("확인"))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    Member? me = authProvider.me;

    return Scaffold(
      appBar: AppBarBase(
        appBarObj: AppBar(),
        centerBuilder: (context) =>
        const Text("마이 페이지",
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
                  me == null ? "로그인 해주세요" : "부모님",
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
              icon: const Icon(Icons.child_care),
              title: "아이 정보 관리",
              onTap: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageKidScreen()))),
          Menu(
              icon: const Icon(Icons.location_on_outlined),
              title: "돌봄 장소 관리",
              onTap: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const ManageDolbomLocationScreen()))),
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
              onTap: () =>
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => const FAQScreen())),
              icon: const Icon(Icons.help_outline)),
          Menu(
              title: "개인정보 이용 정책",
              onTap: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyScreen())),
              icon: Container()),
          Menu(
              title: "이용 약관",
              onTap: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsScreen())),
              icon: Container()),
          Menu(title: "회원 탈퇴", onTap: () {
            showWithDrawlDialog();
          }, icon: Container()),
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
  const Menu({super.key,
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
