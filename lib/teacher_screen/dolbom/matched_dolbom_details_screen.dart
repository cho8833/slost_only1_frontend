import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/provider/teacher_dolbom_provider.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class MatchedDolbomDetailsScreen extends StatefulWidget {
  const MatchedDolbomDetailsScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<MatchedDolbomDetailsScreen> createState() =>
      _MatchedDolbomDetailsScreenState();
}

class _MatchedDolbomDetailsScreenState
    extends State<MatchedDolbomDetailsScreen> {
  late TeacherDolbomProvider dolbomProvider;

  @override
  void initState() {
    dolbomProvider = context.read<TeacherDolbomProvider>();
    super.initState();
  }

  void finishDolbom() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("돌봄 완료"),
              content: const Text("돌봄을 완료하시겠습니까?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "취소",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    dolbomProvider.finishDolbom(widget.dolbom.id).then((_) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                    });
                  },
                  child: const Text(
                    "확인",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        appBarObj: AppBar(),
        title: "돌봄 상세",
        trailingBuilder: (context) => StatusBuilder(
            statusNotifier: dolbomProvider.finishDolbomStatus,
            idleBuilder: (context) {
              return TextButton(
                  onPressed: finishDolbom, child: const Text("돌봄 완료"));
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [DolbomDetail(dolbom: widget.dolbom)],
        ),
      ),
    );
  }
}
