import 'package:flutter/material.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SelectRegularScheduleScreen extends StatefulWidget {
  const SelectRegularScheduleScreen({super.key});

  @override
  State<SelectRegularScheduleScreen> createState() => _SelectRegularScheduleScreenState();
}

class _SelectRegularScheduleScreenState extends State<SelectRegularScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "매주 정기적으로 방문"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
