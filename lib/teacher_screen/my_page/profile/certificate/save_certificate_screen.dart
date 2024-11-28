import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/certificate.dart';
import 'package:slost_only1/provider/certificate_provider.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class SaveCertificateScreen extends StatefulWidget {
  const SaveCertificateScreen({super.key, this.certificate});

  final Certificate? certificate;

  @override
  State<SaveCertificateScreen> createState() => _SaveCertificateScreenState();
}

class _SaveCertificateScreenState extends State<SaveCertificateScreen> {
  late CertificateProvider provider;

  String? title;

  PlatformFile? pdf;

  String? fileName;

  @override
  void initState() {
    super.initState();
    if (widget.certificate != null) {
      title = widget.certificate!.title;
      if (widget.certificate!.fileUrl != null) {
        fileName = fileUrlToKorean(widget.certificate!.fileUrl!);
      }
    }
    provider = context.read<CertificateProvider>();
  }

  String fileUrlToKorean(String fileUrl) {
    List<String> split = fileUrl.split("/");
    String fileName = split.last;
    return Uri.decodeComponent(fileName);
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
    );
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.single;
      if (file.extension != "pdf") {
        Fluttertoast.showToast(msg: "PDF 파일을 선택해주세요");
        return;
      }
      setState(() {
        pdf = file;
        fileName = pdf!.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
          appBarObj: AppBar(),
          title: widget.certificate != null ? "자격증 수정" : "자격증 추가"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubTitleText(
              title: "자격증 이름",
              required: true,
            ),
            const SizedBox(
              height: 8,
            ),
            TextFieldTemplate(
              initValue: title,
              onChange: (text) {
                setState(() {
                  title = text;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const SubTitleText(title: "자격증 파일"),
            const SizedBox(
              height: 8,
            ),
            ButtonBase(
                onTap: () {
                  pickPdf();
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        Text(fileName != null ? fileName! : "자격증 파일을 선택해주세요"))),
            const Spacer(),
            StatusBuilder(
                statusNotifier: provider.saveCertificateStatus,
                idleBuilder: (context) {
                  return ButtonTemplate(
                      title: widget.certificate != null ? "수정하기" : "추가하기",
                      onTap: () {
                        File? file = pdf != null ? File(pdf!.path!) : null;

                        if (widget.certificate != null) {
                          provider
                              .editCertificate(
                                  id: widget.certificate!.id,
                                  title: title!,
                                  file: file)
                              .then((_) {
                            Navigator.pop(context);
                          }).catchError((e) {
                            Fluttertoast.showToast(msg: e.toString());
                          });
                        } else {
                          provider
                              .createCertificate(title: title!, file: file)
                              .then((_) {
                            Navigator.pop(context);
                          }).catchError((e) {
                            Fluttertoast.showToast(msg: e.toString());
                          });
                        }
                      },
                      isEnable: title != null);
                }),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
