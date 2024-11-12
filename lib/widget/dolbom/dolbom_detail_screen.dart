import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/dolbom_time_slot.dart';
import 'package:slost_only1/model/enums/dolbom_status.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class DolbomDetailScreen extends StatefulWidget {
  const DolbomDetailScreen({super.key, required this.dolbom});

  final Dolbom dolbom;

  @override
  State<DolbomDetailScreen> createState() => _DolbomDetailScreenState();
}

class _DolbomDetailScreenState extends State<DolbomDetailScreen> {

  Widget statusCard(DolbomStatus status) {
    late Color cardColor;
    switch (status) {
      case DolbomStatus.matching:
        cardColor = Colors.orange;
      case DolbomStatus.reserved:
        cardColor = Colors.indigo;
      default:
        cardColor = Colors.black54;
    }
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: cardColor.withOpacity(0.2)
        ),
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Text(
          status.title, style: TextStyle(fontSize: 14, color: cardColor),)
    );
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

  String timeSlotToString(DolbomTimeSlot timeSlot) {
    String title = DateFormat("MM/dd").format(timeSlot.startDateTime);
    title += "(${DateFormat.E('ko').format(timeSlot.startDateTime)}) ";
    title +=
    "${DateFormat("hh:mm").format(timeSlot.startDateTime)} ~ ${DateFormat(
        "hh:mm").format(timeSlot.endDateTime)}";
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 상세"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            statusCard(widget.dolbom.status),
            const SizedBox(height: 16,),
            Text(widget.dolbom.category.title, style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 20),),
            const SizedBox(height: 16,),
            Row(
              children: [
                const Text(
                  "아이", style: TextStyle(fontWeight: FontWeight.w700),),
                const SizedBox(width: 8,),
                Text(widget.dolbom.kids.map((kid) => kid.name).join(" "))
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                const Text(
                  "활동비", style: TextStyle(fontWeight: FontWeight.w700),),
                const SizedBox(width: 8,),
                Text("${widget.dolbom.pay}원"),
              ],
            ),
            const SizedBox(height: 16,),
            const Text("방문 일정",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
            const SizedBox(height: 8,),
            Text(getSchedule()),
            const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListView.separated(
                itemCount: widget.dolbom.timeSlots.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 8,),
                itemBuilder: (context, index) {
                  DolbomTimeSlot timeSlot = widget.dolbom.timeSlots[index];
                  return Text(timeSlotToString(timeSlot), style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
