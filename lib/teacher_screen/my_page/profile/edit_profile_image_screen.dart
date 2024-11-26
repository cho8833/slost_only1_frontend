import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class EditProfileImageScreen extends StatefulWidget {
  const EditProfileImageScreen({super.key});

  @override
  State<EditProfileImageScreen> createState() => _EditProfileImageScreenState();
}

class _EditProfileImageScreenState extends State<EditProfileImageScreen> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future<void> pickProfileImage() async {
    XFile? pick = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pick;
    });
  }

  @override
  Widget build(BuildContext context) {
    TeacherProfileProvider provider = context.read<TeacherProfileProvider>();

    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "프로필 사진"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonBase(
                onTap: pickProfileImage,
                child: _ProfileImageCircle(
                  child: image != null
                      ? Image.file(
                          File(image!.path),
                          fit: BoxFit.fitHeight,
                        )
                      : const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                ),
              ),
              const Spacer(),
              StatusBuilder(
                  statusNotifier: provider.editProfileStatus,
                  idleBuilder: (context) {
                    return ButtonTemplate(
                        title: "제출하기",
                        onTap: () {
                          provider.editTeacherProfileImage(image!).then((_) {
                            Navigator.pop(context);
                          }).catchError((e) {
                            Fluttertoast.showToast(msg: e.toString());
                          });
                        },
                        isEnable: image != null);
                  }),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileImageCircle extends StatelessWidget {
  const _ProfileImageCircle({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
            width: 72,
            height: 72,
            child: child));
  }
}