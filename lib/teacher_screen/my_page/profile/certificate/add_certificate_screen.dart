import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/provider/certificate_provider.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class AddCertificateScreen extends StatefulWidget {
  const AddCertificateScreen({super.key});

  @override
  State<AddCertificateScreen> createState() => _AddCertificateScreenState();
}

class _AddCertificateScreenState extends State<AddCertificateScreen> {
  late CertificateProvider provider;

  CreateCertificateContext createContext = CreateCertificateContext();

  @override
  void initState() {
    super.initState();
    provider = context.read<CertificateProvider>();
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "자격증 추가"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText("자격증 이름"),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              onChange: (text) {
                setState(() {
                  createContext.title = text;
                });
              },
            ),
            const Spacer(),
            StatusBuilder(
              statusNotifier: provider.createCertificateStatus,
              idleBuilder: (context) {
                return ButtonTemplate(
                    title: "추가하기", onTap: () {
                      provider.createCertificate(createContext).then((_) {
                        Navigator.pop(context);
                      }).catchError((e) {
                        Fluttertoast.showToast(msg: e.toString());
                      });
                }, isEnable: createContext.validate());
              }
            ),
            const SizedBox(height: 32,),
          ],
        ),
      ),
    );
  }
}
