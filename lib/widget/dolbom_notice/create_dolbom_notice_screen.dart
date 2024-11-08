import 'package:flutter/material.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class CreateDolbomNoticeScreen extends StatefulWidget {
  const CreateDolbomNoticeScreen({super.key});

  @override
  State<CreateDolbomNoticeScreen> createState() => _CreateDolbomNoticeScreenState();
}

class _CreateDolbomNoticeScreenState extends State<CreateDolbomNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 공고 올리기"),

    );
  }
}
