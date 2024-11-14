import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/provider/teacher_dolbom_provider.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/teacher_screen/dolbom/applied_dolbom_detail_screen.dart';
import 'package:slost_only1/teacher_screen/dolbom/done_dolbom_detail_screen.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom/dolbom_item.dart';
import 'package:slost_only1/widget/infinite_scroll_list.dart';

class ManageDolbomScreen extends StatefulWidget {
  const ManageDolbomScreen({super.key});

  @override
  State<ManageDolbomScreen> createState() =>
      _ManageDolbomScreenState();
}

class _ManageDolbomScreenState extends State<ManageDolbomScreen> {
  late TeacherDolbomProvider dolbomProvider;
  late PagingController _pagingController;

  late final Map<String, Future<PagedData<Dolbom>> Function(int)> _title;

  late MapEntry<String, Future<PagedData<Dolbom>> Function(int)> selectedMenu;

  Widget _menu() {
    List<Widget> menus = _title.entries.map((entry) {
      return Expanded(
        child: _MenuButton(
          isSelected: entry.key == selectedMenu.key &&
              entry.value == selectedMenu.value,
          entry: entry,
          onSelect: () {
            setState(() {
              selectedMenu = entry;
            });
            _pagingController.refresh();
          },
        ),
      );
    }).toList();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: menus);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dolbomProvider = context.read<TeacherDolbomProvider>();
    _title = {
      "신청내역": dolbomProvider.getAppliedDolbom,
      "방문일정": (page) {
        return dolbomProvider.getMyDolbom(DolbomStatus.reserved, page);
      },
      "방문기록": (page) {
        return dolbomProvider.getMyDolbom(DolbomStatus.done, page);
      }
    };
    selectedMenu = _title.entries.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        appBarObj: AppBar(),
        leadingBuilder: (context) => const Text(
          "내 방문 관리",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _menu(),
              ],
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xEEEEEEFF),
                child: InfiniteScrollList(pageRequest: (page) {
                  return selectedMenu.value(page);
                }, onMount: (controller) {
                  _pagingController = controller;
                }, itemBuilder: (context, item, index) {
                  return DolbomItem(dolbom: item, onTap: (dolbom) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      late Widget routeScreen;
                      switch (selectedMenu.key) {
                        case "신청내역":
                          routeScreen = AppliedDolbomDetailScreen(dolbom: dolbom);
                        case "방문일정":
                          routeScreen = DoneDolbomDetailScreen(dolbom: dolbom);
                      }
                      return routeScreen;
                    }));

                  });
                })),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatefulWidget {
  const _MenuButton(
      {required this.isSelected, required this.entry, required this.onSelect});

  final bool isSelected;

  final MapEntry<String, Future<PagedData<Dolbom>> Function(int)> entry;

  final void Function() onSelect;

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonBase(
        onTap: widget.onSelect,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: widget.isSelected
                  ? const Border(
                      bottom: BorderSide(color: Colors.black, width: 2))
                  : null),
          alignment: Alignment.center,
          child: Text(
            widget.entry.key,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: widget.isSelected ? Colors.black : Colors.black26),
          ),
        ));
  }
}
