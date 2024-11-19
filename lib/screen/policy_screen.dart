import 'package:flutter/material.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen(
      {super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late WebViewController controller;

  RepositoryContainer rc = RepositoryContainer();

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    rc.noticeRepository.getPolicyUrl().then((url) {
      controller.loadRequest(Uri.parse(url));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "서비스 이용 정책"),
      body: WebViewWidget(controller: controller),
    );
  }
}
