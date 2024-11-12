import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/select_bname_modal.dart';
import 'package:slost_only1/widget/teacher/teacher_profile_card.dart';

class NearTeacherScreen extends StatefulWidget {
  const NearTeacherScreen({super.key});

  @override
  State<NearTeacherScreen> createState() => _NearTeacherScreenState();
}

class _NearTeacherScreenState extends State<NearTeacherScreen> {
  late TeacherProfileProvider provider;

  String? bname;

  final PagingController<int, TeacherProfile> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    provider = context.read<TeacherProfileProvider>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await provider.getNearTeacher(bname, pageKey);
      List<TeacherProfile> newItems = provider.teachers!.content;

      final bool isLastPage = provider.teachers!.last!;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        appBarObj: AppBar(),
        centerBuilder: (context) => const Text("주변 선생님"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("주변 선생님 찾기",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    ButtonBase(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  SelectBnameModal(onSelect: (bname) {
                                    setState(() {
                                      this.bname = bname.name;
                                    });
                                  }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black12)),
                          padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                          child: Row(
                            children: [
                              Text(bname ?? "지역 선택"),
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
              child: PagedListView.separated(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<TeacherProfile>(
                      itemBuilder: (context, item, index) =>
                          TeacherProfileCard(teacher: item)),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      )),
            ),
          )
        ],
      ),
    );
  }
}
