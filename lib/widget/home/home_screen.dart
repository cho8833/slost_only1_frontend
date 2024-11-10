import 'package:flutter/material.dart';
import 'package:slost_only1/widget/main_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBarObj: AppBar()),
      body: const Placeholder(),
    );
  }
}
