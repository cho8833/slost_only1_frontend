import 'package:flutter/material.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/manage_dolbom_location_screen.dart';
import 'package:slost_only1/widget/kid/manage_kid_screen.dart';

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
                me == null ? Container() : Text(me.phoneNumber)
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Menu(title: "아이 정보 관리",
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const ManageKidScreen()))),
          Menu(title: "돌봄 장소 관리",
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (
                      context) => const ManageDolbomLocationScreen())))

        ],
      ),
    );
  }
}


class Menu extends StatelessWidget {
  const Menu({super.key, required this.title, required this.onTap});

  final String title;

  final void Function() onTap;

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
                      const Icon(Icons.child_care),
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
