import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/teacher_screen/my_page/profile/edit_how_became_teacher_screen.dart';
import 'package:slost_only1/teacher_screen/my_page/profile/edit_introduce_screen.dart';
import 'package:slost_only1/teacher_screen/my_page/profile/edit_profile_image_screen.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/item_container.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/widget/teacher_profile/profile_image_circle.dart';
import 'package:slost_only1/widget/text_template.dart';
import 'package:status_builder/status_builder.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TeacherProfileProvider provider;

  @override
  void initState() {
    provider = context.read<TeacherProfileProvider>();
    provider.getMyTeacherProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "선생님 프로필"),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: StatusBuilder(
              statusNotifier: provider.getMyTeacherProfileStatus,
              successBuilder: (context) {
                MyTeacherProfile myTeacherProfile = provider.myTeacherProfile;
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileItemContainer(
                            value: myTeacherProfile.profileImageUrl,
                            valueWidget: (context, value) {
                              return Center(
                                  child: ProfileImageCircle(imageUrl: value));
                            },
                            title: "프로필 사진",
                            onEditTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileImageScreen()));
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ProfileItemContainer(
                        value: myTeacherProfile.introduce,
                        valueWidget: (context, value) => Text(value),
                        title: "한 문장 자기소개",
                        onEditTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditIntroduceScreen(
                                        introduce: myTeacherProfile.introduce,
                                      )));
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    ProfileItemContainer(
                        value: myTeacherProfile.howBecameTeacher,
                        valueWidget: (context, value) {
                          return Text(value);
                        },
                        title: "선생님이 된 계기",
                        onEditTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditHowBecameTeacherScreen(
                                        howBecameTeacher:
                                            myTeacherProfile.howBecameTeacher,
                                      )));
                        }),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                );
              })),
    );
  }
}

class ProfileItemContainer<T> extends StatelessWidget {
  const ProfileItemContainer(
      {super.key,
      required this.value,
      required this.title,
      required this.onEditTap,
      required this.valueWidget});

  final T? value;

  final String title;

  final void Function() onEditTap;

  final Widget Function(BuildContext, T) valueWidget;

  bool isEdit() {
    return value != null;
  }

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubTitleText(title: title),
            isEdit()
                ? GestureDetector(
                    onTap: onEditTap,
                    child: const Row(
                      children: [Icon(Icons.edit_outlined), Text("수정하기")],
                    ),
                  )
                : Container()
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        isEdit() ? valueWidget(context, value!) : Container(),
        const SizedBox(
          height: 8,
        ),
        isEdit()
            ? Container()
            : ButtonTemplate(title: "등록하기", onTap: onEditTap, isEnable: true)
      ],
    ));
  }
}
