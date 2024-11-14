import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/provider/teacher_dolbom_provider.dart';
import 'package:slost_only1/teacher_screen/dolbom/matching_dolbom_detail_screen.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom/dolbom_item.dart';
import 'package:slost_only1/parent_screen/manage_dolbom/manage_dolbom_screen.dart';
import 'package:slost_only1/widget/infinite_scroll_list.dart';
import 'package:slost_only1/widget/select_address_modal.dart';

class MatchingDolbomScreen extends StatefulWidget {
  const MatchingDolbomScreen({super.key});

  @override
  State<MatchingDolbomScreen> createState() => _MatchingDolbomScreenState();
}

class _MatchingDolbomScreenState extends State<MatchingDolbomScreen> {
  late TeacherDolbomProvider dolbomProvider;
  late PagingController pagingController;
  String? sigungu;

  @override
  void initState() {
    dolbomProvider = context.read<TeacherDolbomProvider>();
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarBase(
          backgroundColor: Colors.white,
          appBarObj: AppBar(),
          leadingBuilder: (context) => const Text(
            "돌봄 공고",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16,0,16,16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ButtonBase(
                          onTap: () {
                            showModalBottomSheet<List<SelectedSigungu>>(
                                context: context,
                                builder: (context) {
                                  return const SelectAddressModal();
                                }).then((data) {
                              if (data == null) {
                                return;
                              }
                              setState(() {
                                sigungu = data.first.sigungu;
                              });
                              pagingController.notifyPageRequestListeners(1);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black12)),
                            padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                            child: Row(
                              children: [
                                Text(sigungu ?? "지역 선택"),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: InfiniteScrollList<Dolbom>(pageRequest: (pageKey) {
                return dolbomProvider.getMatchingDolbom(pageKey);
              }, onMount: (controller) {
                pagingController = controller;
              }, itemBuilder: (context, item, index) {
                return DolbomItem(dolbom: item, onTap: (dolbom) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MatchingDolbomDetailScreen(dolbom: item)));
                });
              }),
            ))
          ],
        ));
  }
}
