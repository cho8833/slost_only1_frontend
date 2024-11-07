import 'package:flutter/material.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ButtonBase(
                onTap: () {
                  authProvider.signInIdPw("username", "password").then((_) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  });
                },
                child: const Text("로그인"))));
  }
}
