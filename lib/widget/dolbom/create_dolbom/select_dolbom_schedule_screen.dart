import 'package:flutter/material.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom/create_dolbom/create_dolbom_notice_context.dart';
import 'package:slost_only1/widget/dolbom/create_dolbom/select_regular_schedule_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDolbomScheduleScreen extends StatefulWidget {
  const SelectDolbomScheduleScreen({super.key, required this.createContext});

  final CreateDolbomNoticeContext createContext;

  @override
  State<SelectDolbomScheduleScreen> createState() =>
      _SelectDolbomScheduleScreenState();
}

class _SelectDolbomScheduleScreenState
    extends State<SelectDolbomScheduleScreen> {
  List<DateTime> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 신청하기"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "방문 날짜",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonBase(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SelectRegularScheduleScreen()));
                    },
                    child: const Row(
                      children: [
                        Text("매주 정기적으로 방문"),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.chevron_right)
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) {
                return selected.contains(day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (selected.contains(selectedDay)) {
                    selected.remove(selectedDay);
                  } else {
                    selected.add(selectedDay);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
