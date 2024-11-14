import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/provider/teacher_dolbom_provider.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class MatchingDolbomDetailScreen extends StatefulWidget {
  const MatchingDolbomDetailScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<MatchingDolbomDetailScreen> createState() =>
      _MatchingDolbomDetailScreenState();
}

class _MatchingDolbomDetailScreenState
    extends State<MatchingDolbomDetailScreen> {

  late TeacherDolbomProvider provider;

  @override
  void initState() {
    provider = context.read<TeacherDolbomProvider>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatusBuilder(
        statusNotifier: provider.applyDolbomStatus,
        idleBuilder: (context) {
          return FloatingActionButton.extended(
            onPressed: () {
              provider.applyDolbom(widget.dolbom.id).then((_) {
                Fluttertoast.showToast(msg: "지원에 성공했습니다");
              }).catchError((e) {
                Fluttertoast.showToast(msg: e.toString());
              });
            },
            label: const Text("지원하기"),
            icon: const Icon(Icons.edit),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 상세"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [DolbomDetail(dolbom: widget.dolbom)],
        ),
      ),
    );
  }
}
