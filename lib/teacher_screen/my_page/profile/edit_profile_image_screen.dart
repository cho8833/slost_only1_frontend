import 'package:flutter/material.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class EditProfileImageScreen extends StatefulWidget {
  const EditProfileImageScreen({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  State<EditProfileImageScreen> createState() => _EditProfileImageScreenState();
}

class _EditProfileImageScreenState extends State<EditProfileImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "프로필 사진"),
    );
  }
}
