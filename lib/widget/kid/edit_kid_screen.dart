import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/data/kid_req.dart';
import 'package:slost_only1/enums/gender.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/provider/kid_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class EditKidScreen extends StatefulWidget {
  const EditKidScreen({super.key, this.kid});

  // kid 가 null 이면 create
  // kid 가 null 이 아니면 edit
  final Kid? kid;

  @override
  State<EditKidScreen> createState() => _EditKidScreenState();
}

class _EditKidScreenState extends State<EditKidScreen> {
  String? name;

  String? tendency;

  String? remark;

  Gender? gender;

  DateTime? birthday;

  late final KidProvider kidProvider;

  @override
  void initState() {
    if (widget.kid != null) {
      name = widget.kid!.name;
      tendency = widget.kid!.tendency;
      remark = widget.kid!.remark;
      birthday = widget.kid!.birthday;
      gender = widget.kid!.gender;
    }
    kidProvider = context.read<KidProvider>();
    super.initState();
  }

  Widget inputField(Function(String) onChange, {String? initValue}) {
    return TextFormField(
      onChanged: onChange,
      initialValue: initValue,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0))),
    );
  }

  Widget inputTitle(String text, bool isRequired) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        isRequired
            ? const Text(
                "*",
                style: TextStyle(fontSize: 16, color: Colors.red),
              )
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
          appBarObj: AppBar(),
          title: widget.kid != null ? "아이 정보 수정" : "아이 정보 추가"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputTitle("이름", true),
              inputField((text) {
                name = text;
              }, initValue: name),
              const SizedBox(
                height: 24,
              ),
              inputTitle("생년월일", true),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12)),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ButtonBase(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime(2010),
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now())
                            .then((selectedDate) {
                          setState(() {
                            birthday = selectedDate;
                          });
                        });
                      },
                      child: Text(
                        birthday != null
                            ? DateFormat("yyyy년 MM월 dd일").format(birthday!)
                            : "날짜를 선택해주세요",
                        style: TextStyle(
                            color: birthday != null
                                ? Colors.black
                                : Colors.black12),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              inputTitle("성별", true),
              Row(
                children: [
                  Expanded(
                    child: ButtonBase(
                        onTap: () {
                          setState(() {
                            gender = Gender.female;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: gender == Gender.female
                                        ? Colors.black
                                        : Colors.black12,
                                    width: 1)),
                            child: const Text("여자아이"))),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: ButtonBase(
                          onTap: () {
                            setState(() {
                              gender = Gender.male;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: gender == Gender.male
                                        ? Colors.black
                                        : Colors.black12,
                                    width: 1)),
                            child: const Text("남자아이"),
                          )))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              inputTitle("성향", false),
              inputField((text) {
                tendency = text;
              }, initValue: tendency),
              const SizedBox(
                height: 24,
              ),
              inputTitle("특이 사항", false),
              inputField((text) {
                remark = text;
              }, initValue: remark),
              const SizedBox(
                height: 24,
              ),
              ButtonBase(
                  onTap: () {
                    String? validation =
                        kidProvider.validateKidInfo(name, gender, birthday);
                    if (validation != null) {
                      Fluttertoast.showToast(msg: validation);
                      return;
                    }
                    if (widget.kid != null) {
                      kidProvider.editKid(KidEditReq(widget.kid!.id, name!,
                          birthday!, gender!, tendency, remark)).then((_) {
                            Navigator.pop(context);
                      }).catchError((e) {
                        Fluttertoast.showToast(msg: e.toString());
                      });
                    } else {
                      kidProvider.addKid(KidCreateReq(
                          name!, birthday!, gender!, tendency, remark)).then((_) {
                            Navigator.pop(context);
                      }).catchError((e) {
                        Fluttertoast.showToast(msg: e.toString());
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kidProvider.validateKidInfo(
                                    name, gender, birthday) ==
                                null
                            ? Colors.blueAccent
                            : Colors.black12),
                    alignment: Alignment.center,
                    child: Text(
                      widget.kid != null ? "수정하기" : "추가하기",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
