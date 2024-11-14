import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/widget/dolbom/create_dolbom/create_dolbom_context.dart';
import 'package:slost_only1/widget/dolbom/parent/parent_manage_dolbom_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateDolbomContext(),
      builder: (context,_) {
        return const MaterialApp(
          home: ParentManageDolbomScreen(),
        );
      }
    );
  }
}
