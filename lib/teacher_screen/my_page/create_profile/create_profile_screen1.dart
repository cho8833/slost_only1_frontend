import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/enums/gender.dart';
import 'package:slost_only1/provider/certificate_provider.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/text_field_template.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/teacher_screen/certificate/add_certificate_screen.dart';
import 'package:slost_only1/widget/certificate/certificate_card.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/teacher_screen/my_page/create_profile/create_profile_screen2.dart';
import 'package:status_builder/status_builder.dart';

class CreateProfileScreen1 extends StatefulWidget {
  const CreateProfileScreen1({super.key});

  @override
  State<CreateProfileScreen1> createState() => _CreateProfileScreen1State();
}

class _CreateProfileScreen1State extends State<CreateProfileScreen1> {
  late CertificateProvider certificateProvider;
  late TeacherProfileProvider teacherProfileProvider;

  final ImagePicker picker = ImagePicker();

  TeacherProfileCreateReq req = TeacherProfileCreateReq();

  Future<void> pickProfileImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      req.profileImage = image;
    });
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
    );
  }

  @override
  void initState() {
    super.initState();
    teacherProfileProvider = context.read<TeacherProfileProvider>();
    certificateProvider = context.read<CertificateProvider>();
    certificateProvider.getMyCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        appBarObj: AppBar(),
        title: '선생님 프로필 등록',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText("프로필 이미지"),
              const SizedBox(
                height: 8,
              ),
              ButtonBase(
                onTap: () {
                  pickProfileImage();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 72,
                      child: req.profileImage != null
                          ? Image.file(
                              File(req.profileImage!.path),
                              fit: BoxFit.fitHeight,
                            )
                          : const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              titleText("프로필 이름"),
              const SizedBox(
                height: 8,
              ),
              TextFieldTemplate(
                onChange: (text) {
                  req.profileName = text;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              titleText("이름"),
              const SizedBox(
                height: 8,
              ),
              TextFieldTemplate(
                onChange: (text) {
                  req.name = text;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              titleText("생일"),
              ButtonBase(
                onTap: () {
                  DateTime now = DateTime.now();
                  DateTime initDate =
                      DateTime(now.year - 20, now.month, now.day);
                  showDatePicker(
                          context: context, firstDate: initDate, lastDate: now)
                      .then((selectedDate) {
                    setState(() {
                      req.birthday = selectedDate;
                    });
                  });
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12, width: 1)),
                  padding: const EdgeInsets.all(16),
                  child: Text(req.birthday != null
                      ? DateFormat("yyyy년 MM월 dd일").format(req.birthday!)
                      : "날짜를 선택해주세요"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              titleText("성별"),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonBase(
                        onTap: () {
                          setState(() {
                            req.gender = Gender.female;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: req.gender == Gender.female
                                        ? Colors.black
                                        : Colors.black12,
                                    width: 1)),
                            child: const Text("여자"))),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: ButtonBase(
                          onTap: () {
                            setState(() {
                              req.gender = Gender.male;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: req.gender == Gender.male
                                        ? Colors.black
                                        : Colors.black12,
                                    width: 1)),
                            child: const Text("남자"),
                          ))),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              titleText("자격증"),
              const SizedBox(
                height: 8,
              ),
              StatusBuilder(
                statusNotifier: certificateProvider.getCertificateStatus,
                successBuilder: (context) =>
                    certificateProvider.certificates.isEmpty
                        ? const Center(
                            child: Text(
                            "자격증을 추가해주세요",
                          ))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: certificateProvider.certificates.length,
                            itemBuilder: (context, index) {
                              return CertificateCard(
                                  certificate:
                                      certificateProvider.certificates[index]);
                            },
                          ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: ButtonBase(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddCertificateScreen()));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black12),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.add),
                    )),
              ),
              const SizedBox(
                height: 32,
              ),
              ButtonTemplate(
                  title: "다음",
                  onTap: () {
                    if (!req.validateBaseInfo()) {
                      Fluttertoast.showToast(msg: "값이 잘못되었습니다");
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateProfileScreen2(req: req)));
                  },
                  isEnable: req.validateBaseInfo())
            ],
          ),
        ),
      ),
    );
  }
}
