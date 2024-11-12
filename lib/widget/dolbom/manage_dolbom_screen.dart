import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/dolbom_time_slot.dart';
import 'package:slost_only1/model/enums/dolbom_status.dart';
import 'package:slost_only1/provider/dolbom_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail_screen.dart';
import 'package:slost_only1/widget/main_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class ManageDolbomScreen extends StatefulWidget {
  const ManageDolbomScreen({super.key});

  @override
  State<ManageDolbomScreen> createState() => _ManageDolbomScreenState();
}

class _ManageDolbomScreenState extends State<ManageDolbomScreen> {
  late DolbomProvider dolbomProvider;

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
            dolbomProvider.getMyDolbom(entry.value);
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
    dolbomProvider = context.read<DolbomProvider>();
    selectedMenu = _title.entries.first;
    dolbomProvider.getMyDolbom(selectedMenu.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBarObj: AppBar()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "방문",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                _menu(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xEEEEEEFF),
              child: StatusBuilder(
                statusNotifier: dolbomProvider.getMyDolbomStatus,
                successBuilder: (context) => ListView.separated(
                  separatorBuilder: (context, _) => const SizedBox(
                    height: 8,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DolbomItem(
                      dolbom: dolbomProvider.myDolboms!.content[index],
                    );
                  },
                  itemCount: dolbomProvider.myDolboms!.content.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DolbomItem extends StatefulWidget {
  const DolbomItem({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<DolbomItem> createState() => _DolbomItemState();
}

class _DolbomItemState extends State<DolbomItem> {
  String getTitle() {
    DolbomTimeSlot earlyTimeSlot = widget.dolbom.timeSlots.first;
    for (int i = 1; i < widget.dolbom.timeSlots.length; i++) {
      DolbomTimeSlot compare = widget.dolbom.timeSlots[i];
      if (compare.startDateTime.isBefore(earlyTimeSlot.startDateTime)) {
        earlyTimeSlot = compare;
      }
    }
    String title = DateFormat("MM/dd").format(earlyTimeSlot.startDateTime);
    title += "(${DateFormat.E('ko').format(earlyTimeSlot.startDateTime)}) ";
    title +=
        "${DateFormat("hh:mm").format(earlyTimeSlot.startDateTime)} ~ ${DateFormat("hh:mm").format(earlyTimeSlot.endDateTime)}";
    return title;
  }

  String getSchedule() {
    if (widget.dolbom.weeklyRepeat) {
      String schedule = "[주 ${widget.dolbom.dayOfWeeks!.length}회] ";
      schedule += widget.dolbom.dayOfWeeks!.join(",");
      return schedule;
    } else {
      DolbomTimeSlot timeslot = widget.dolbom.timeSlots.first;
      String title = DateFormat("MM/dd").format(timeslot.startDateTime);
      title += "(${DateFormat.E('ko').format(timeslot.startDateTime)}) ";
      if (widget.dolbom.timeSlots.length > 1) {
        title += "외 ${widget.dolbom.timeSlots.length - 1}개";
      }
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DolbomDetailScreen(dolbom: widget.dolbom)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTitle(),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              widget.dolbom.category.title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text(
                  "아이",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(widget.dolbom.kids.map((kid) => kid.name).join(" "))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "전체 일정",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(getSchedule())
              ],
            )
          ],
        ),
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
