import 'package:flutter/material.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/edit_colbom_location_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class ManageDolbomLocationScreen extends StatefulWidget {
  const ManageDolbomLocationScreen({super.key});

  @override
  State<ManageDolbomLocationScreen> createState() => _ManageDolbomLocationScreenState();
}

class _ManageDolbomLocationScreenState extends State<ManageDolbomLocationScreen> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 장소 관리"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(child: DolbomLocationList()),
            const SizedBox(
              height: 8,
            ),
            ButtonBase(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditDolbomLocationScreen()));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blueAccent),
                child: const Text(
                  "돌봄 장소 추가",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DolbomLocationList extends StatelessWidget {
  const DolbomLocationList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
