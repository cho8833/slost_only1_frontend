import 'package:flutter/material.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen(
      {super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  late WebViewController controller;

  RepositoryContainer rc = RepositoryContainer();

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse("https://yellow-beginner-483.notion.site/13ffda39711380728923fd11310af8c9?pvs=4"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "개인정보 이용 정책"),
      body: WebViewWidget(controller: controller),
    );
  }
}
