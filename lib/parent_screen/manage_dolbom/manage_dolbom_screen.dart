import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/parent_screen/manage_dolbom/done_dolbom_details_screen.dart';
import 'package:slost_only1/parent_screen/manage_dolbom/matched_dolbom_details_screen.dart';
import 'package:slost_only1/parent_screen/manage_dolbom/matching_dolbom_details_screen.dart';
import 'package:slost_only1/provider/parent_dolbom_provider.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom/dolbom_item.dart';
import 'package:slost_only1/widget/infinite_scroll_list.dart';

class ParentManageDolbomScreen extends StatefulWidget {
  const ParentManageDolbomScreen({super.key});

  @override
  State<ParentManageDolbomScreen> createState() =>
      _ParentManageDolbomScreenState();
}

class _ParentManageDolbomScreenState extends State<ParentManageDolbomScreen> {
  late ParentDolbomProvider dolbomProvider;
  late PagingController _pagingController;

  final Map<String, DolbomStatus> _title = {
    "신청내역": DolbomStatus.matching,
    "방문일정": DolbomStatus.reserved,
    "방문기록": DolbomStatus.done
  };

  late MapEntry<String, DolbomStatus> selectedMenu;

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
    dolbomProvider = context.read<ParentDolbomProvider>();
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
                  return dolbomProvider.getMyDolbom(selectedMenu.value);
                }, onMount: (controller) {
                  _pagingController = controller;
                }, itemBuilder: (context, item, index) {
                  return DolbomItem(
                    dolbom: item,
                    onTap: (dolbom) {
                      late Widget routeScreen;
                      switch (selectedMenu.value) {
                        case DolbomStatus.matching:
                          routeScreen =
                              MatchingDolbomDetailScreen(dolbom: dolbom);
                        case DolbomStatus.reserved:
                          routeScreen = MatchedDolbomDetailsScreen(dolbom: dolbom);
                        default:
                          routeScreen = DoneDolbomDetailsScreen(dolbom: dolbom);
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => routeScreen)).then((_) {
                            _pagingController.refresh();
                      });
                    },
                  );
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

  final MapEntry<String, DolbomStatus> entry;

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
