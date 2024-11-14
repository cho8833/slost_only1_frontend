import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/dolbom_time_slot.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom/dolbom_detail.dart';

class DolbomItem extends StatefulWidget {
  const DolbomItem({super.key, required this.dolbom, required this.onTap});

  final Dolbom dolbom;

  final void Function(Dolbom) onTap;

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
        widget.onTap(widget.dolbom);
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
            ),
            const SizedBox(height: 16,),
          ],

        ),
      ),
    );
  }
}