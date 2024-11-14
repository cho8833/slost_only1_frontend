import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';
import 'package:slost_only1/parent_screen/create_dolbom/select_kid_screen.dart';
import 'package:slost_only1/widget/infinite_scroll_list.dart';
import 'package:slost_only1/widget/select_address_modal.dart';
import 'package:slost_only1/widget/teacher_profile/teacher_profile_card.dart';

class NearTeacherScreen extends StatefulWidget {
  const NearTeacherScreen({super.key});

  @override
  State<NearTeacherScreen> createState() => _NearTeacherScreenState();
}

class _NearTeacherScreenState extends State<NearTeacherScreen> {
  late TeacherProfileProvider provider;

  String? sigungu;

  late PagingController _pagingController;

  @override
  void initState() {
    super.initState();
    provider = context.read<TeacherProfileProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        backgroundColor: Colors.white,
        appBarObj: AppBar(),
        leadingBuilder: (context) => const Text("주변 선생님",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        trailingBuilder: (context) => TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (context) => CreateDolbomContext(),
                          builder: (context, _) {
                            return const SelectKidScreen();
                          })));
            },
            child: const Text("공고 올리기")),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ButtonBase(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const SelectAddressModal();
                              }).then((data) {
                            if (data == null) {
                              return;
                            }
                            setState(() {
                              sigungu =
                                  (data as List<SelectedSigungu>).first.sigungu;
                            });
                            _pagingController.refresh();
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
          ), // header

          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: InfiniteScrollList(
                    pageRequest: (page) {
                      return provider.getNearTeacher(sigungu, page);
                    },
                    onMount: (controller) {
                      _pagingController = controller;
                    },
                    itemBuilder: (context, item, index) {
                      return TeacherProfileCard(teacher: item);
                    })),
          )
        ],
      ),
    );
  }
}
