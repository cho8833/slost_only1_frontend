import 'package:flutter/material.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen(
      {super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late WebViewController controller;

  RepositoryContainer rc = RepositoryContainer();

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    rc.noticeRepository.getFAQUrl().then((url) {
      controller.loadRequest(Uri.parse(url));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "자주 묻는 질문"),
      body: WebViewWidget(controller: controller),
    );
  }
}
