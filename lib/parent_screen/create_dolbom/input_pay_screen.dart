import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/provider/parent_dolbom_provider.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_success_screen.dart';
import 'package:slost_only1/parent_screen/main_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class InputPayScreen extends StatefulWidget {
  const InputPayScreen({super.key});

  @override
  State<InputPayScreen> createState() => _InputPayScreenState();
}

class _InputPayScreenState extends State<InputPayScreen> {
  late CreateDolbomContext createContext;
  late ParentDolbomProvider dolbomProvider;

  @override
  void initState() {
    createContext = context.read<CreateDolbomContext>();
    dolbomProvider = context.read<ParentDolbomProvider>();
    pay = createContext.pay;
    super.initState();
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  int? pay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 신청하기"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText("예상 금액"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldTemplate(
                    onChange: (text) {
                      setState(() {
                        pay = int.parse(text);
                      });
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: 8),
                const Text("원")
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            StatusBuilder(
                statusNotifier: dolbomProvider.postDolbomStatus,
                idleBuilder: (context) {
                  return ButtonTemplate(
                      title: "신청하기",
                      onTap: () {
                        createContext.pay = pay;
                        dolbomProvider.postDolbom(createContext).then((_) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const CreateDolbomSuccessScreen()),
                                  (route) =>
                              route is MaterialPageRoute &&
                                  route.builder(context) is MainScreen);
                        }).catchError((e) {
                          Fluttertoast.showToast(msg: e.toString());
                        });
                      },
                      isEnable: pay != null);
                })
          ],
        ),
      ),
    );
  }
}
