import 'package:flutter/material.dart';
import 'package:slost_only1/widget/button_base.dart';

class CreateDolbomSuccessScreen extends StatelessWidget {
  const CreateDolbomSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "돌봄 신청 완료!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 48,
              ),
              ButtonTemplate(
                  title: "홈으로 돌아가기",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isEnable: true)
            ],
          ),
        ),
      ),
    );
  }
}
