import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/provider/dolbom_provider.dart';

class MatchingDolbomScreen extends StatefulWidget {
  const MatchingDolbomScreen({super.key});

  @override
  State<MatchingDolbomScreen> createState() => _MatchingDolbomScreenState();
}

class _MatchingDolbomScreenState extends State<MatchingDolbomScreen> {
  late DolbomProvider dolbomProvider;

  @override
  void initState() {
    dolbomProvider = context.read<DolbomProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
