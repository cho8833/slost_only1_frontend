import 'package:flutter/material.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen(
      {super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  late WebViewController controller;

  RepositoryContainer rc = RepositoryContainer();

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse("https://yellow-beginner-483.notion.site/154fda39711380ae9354c0d81312c2bd?pvs=4"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "서비스 이용 약관"),
      body: WebViewWidget(controller: controller),
    );
  }
}
