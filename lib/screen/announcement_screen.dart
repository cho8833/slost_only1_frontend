import 'package:flutter/material.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen(
      {super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  late WebViewController controller;

  RepositoryContainer rc = RepositoryContainer();

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    rc.noticeRepository.getAnnouncementUrl().then((url) {
      controller.loadRequest(Uri.parse(url));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "공지사항"),
      body: WebViewWidget(controller: controller),
    );
  }
}
