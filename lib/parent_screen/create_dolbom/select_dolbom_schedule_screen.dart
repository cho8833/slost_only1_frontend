import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/enums/day_of_week.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';
import 'package:slost_only1/parent_screen/create_dolbom/select_category_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDolbomScheduleScreen extends StatefulWidget {
  const SelectDolbomScheduleScreen({super.key});

  @override
  State<SelectDolbomScheduleScreen> createState() =>
      _SelectDolbomScheduleScreenState();
}

class _SelectDolbomScheduleScreenState
    extends State<SelectDolbomScheduleScreen> {
  late CreateDolbomContext createContext;

  @override
  void initState() {
    super.initState();
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  @override
  Widget build(BuildContext context) {
    createContext = context.watch<CreateDolbomContext>();
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 신청하기"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText("방문 날짜/시간을\n선택해주세요"),
              const SizedBox(
                height: 16,
              ),
              ButtonBase(
                  onTap: () {
                    createContext.weeklyRepeat = false;
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: createContext.weeklyRepeat
                                ? Colors.black12
                                : Colors.blueAccent)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "일반 방문",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "하루 또는 여러 날짜 방문",
                          style: TextStyle(color: Colors.black38),
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              ButtonBase(
                  onTap: () {
                    createContext.weeklyRepeat = true;
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: createContext.weeklyRepeat
                                ? Colors.blueAccent
                                : Colors.black12)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "정기 방문",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "매주 원하는 요일 방문",
                          style: TextStyle(color: Colors.black38),
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 48,
              ),
              titleText("방문 날짜"),
              createContext.weeklyRepeat
                  ? const RegularDolbomCalendar()
                  : const GeneralDolbomCalendar(),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText("방문 시간"),
                  ButtonBase(
                    onTap: () {
                      setState(() {
                        createContext.setSeveralTime =
                            !createContext.setSeveralTime;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: createContext.setSeveralTime
                              ? Colors.blueAccent
                              : Colors.black12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text("날짜별 설정")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              () {
                List<TimeSlot> days = createContext.weeklyRepeat
                    ? context.select<CreateDolbomContext, List<TimeSlot>>(
                        (p) => p.repeatDays)
                    : context.select<CreateDolbomContext, List<TimeSlot>>(
                        (p) => p.selectedDays);
                return days.isNotEmpty
                    ? createContext.setSeveralTime
                        ? SelectSeveralTime(timeSlots: days)
                        : SelectTime(
                            startTime: createContext.startTime,
                            endTime: createContext.endTime,
                            onStartChange: (dateTime) {
                              createContext.startTime = dateTime;
                            },
                            onEndChange: (dateTime) {
                              createContext.endTime = dateTime;
                            },
                          )
                    : Container();
              }(),
              const SizedBox(
                height: 32,
              ),
              ButtonTemplate(
                  title: "다음",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                                value: createContext,
                                child: const SelectCategoryScreen())));
                  },
                  isEnable: true)
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralDolbomCalendar extends StatefulWidget {
  const GeneralDolbomCalendar({super.key});

  @override
  State<GeneralDolbomCalendar> createState() => _GeneralDolbomCalendarState();
}

class _GeneralDolbomCalendarState extends State<GeneralDolbomCalendar> {
  late CreateDolbomContext createContext;

  @override
  void initState() {
    createContext = context.read<CreateDolbomContext>();
    selected = createContext.selectedDays.map((d) => d.date).toList();
    super.initState();
  }

  List<DateTime> selected = [];

  void onSelect(DateTime selectedDay) {
    setState(() {
      if (selected.contains(selectedDay)) {
        selected.remove(selectedDay);
      } else {
        selected.add(selectedDay);
      }
    });
    createContext.selectedDays = selected.map((d) => TimeSlot.from(d)).toList();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Column(
      children: [
        TableCalendar(
          startingDayOfWeek: StartingDayOfWeek.monday,
          focusedDay: now,
          firstDay: now,
          lastDay: DateTime.utc(now.year + 10, now.month, now.day),
          selectedDayPredicate: (day) {
            return selected.contains(day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            onSelect(selectedDay);
          },
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xF2F2F2FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: createContext.selectedDays.isEmpty
              ? const Text(
                  "방문 날짜를 선택해주세요",
                  textAlign: TextAlign.center,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(DateFormat("MM월 dd일")
                            .format(createContext.selectedDays.first.date)),
                        const SizedBox(
                          width: 4,
                        ),
                        createContext.selectedDays.length > 1
                            ? Text(
                                "외 ${createContext.selectedDays.length - 1}개 날짜")
                            : Container()
                      ],
                    ),
                    Row(
                      children: [
                        const Text("총 "),
                        Text(
                          createContext.selectedDays.length.toString(),
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                        const Text("회 방문")
                      ],
                    )
                  ],
                ),
        ),
      ],
    );
  }
}

class RegularDolbomCalendar extends StatefulWidget {
  const RegularDolbomCalendar({super.key});

  @override
  State<RegularDolbomCalendar> createState() => _RegularDolbomCalendarState();
}

class _RegularDolbomCalendarState extends State<RegularDolbomCalendar> {
  late CreateDolbomContext createContext;

  DateTime focusDay = DateTime.now();

  Widget dowButtons() {
    List<Widget> dows = DayOfWeek.values.map((dow) {
      bool isSelected = createContext.repeatDows.contains(dow);
      return ButtonBase(
        onTap: () {
          if (createContext.repeatDows.contains(dow)) {
            createContext.notifyChange(() {
              createContext.repeatDows.remove(dow);
              createContext.repeatDays.removeWhere((timeslot) {
                return timeslot.date.weekday == dow.index + 1;
              });
            });
          } else {
            createContext.notifyChange(() {
              createContext.repeatDows.add(dow);
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blueAccent : Colors.transparent),
          child: Text(
            dow.title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      );
    }).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dows,
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    createContext = context.watch<CreateDolbomContext>();
    DateTime now = DateTime.now();
    return Column(
      children: [
        dowButtons(),
        TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            enabledDayPredicate: (date) {
              if (createContext.repeatDows
                  .contains(DayOfWeek.values[date.weekday - 1])) {
                return true;
              } else {
                return false;
              }
            },
            onDaySelected: (selectedDate, _) {
              if (createContext.repeatStartDate == null) {
                createContext.repeatStartDate = selectedDate;
              } else {
                if (createContext.repeatStartDate!.isBefore(selectedDate)) {
                  if (createContext.repeatEndDate != null) {
                    createContext.repeatStartDate = selectedDate;
                    createContext.repeatEndDate = null;
                  } else {
                    createContext.repeatEndDate = selectedDate;
                  }
                } else if (isSameDay(
                    createContext.repeatStartDate!, selectedDate)) {
                  createContext.repeatStartDate = null;
                  createContext.repeatEndDate = null;
                } else {
                  createContext.repeatStartDate = selectedDate;
                }
              }
              createContext.calRepeatDays();
            },
            onRangeSelected: (startDate, endDate, _) {
              createContext.repeatStartDate = startDate;
              createContext.repeatEndDate = endDate;
              if (endDate != null) {
                createContext.calRepeatDays();
              }
              if (startDate != null) {
                createContext.repeatDays = [TimeSlot.from(startDate)];
              }
            },
            onPageChanged: (focusDay) {
              this.focusDay = focusDay;
            },
            selectedDayPredicate: (dateTime) {
              return createContext.repeatDays
                      .indexWhere((p) => isSameDay(p.date, dateTime)) !=
                  -1;
            },
            focusedDay: focusDay,
            firstDay: now,
            lastDay: DateTime.utc(now.year + 10, now.month, now.day)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xF2F2F2FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: createContext.repeatDays.isEmpty
              ? const Text(
                  "방문 날짜를 선택해주세요",
                  textAlign: TextAlign.center,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(DateFormat("MM월 dd일부터")
                            .format(createContext.repeatDays.first.date)),
                        const SizedBox(
                          width: 4,
                        ),
                        createContext.repeatEndDate != null
                            ? Text(DateFormat("MM월 dd일까지")
                                .format(createContext.repeatEndDate!))
                            : Container()
                      ],
                    ),
                    Row(
                      children: [
                        const Text("총 "),
                        Text(
                          createContext.repeatDays.length.toString(),
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                        const Text("회 방문")
                      ],
                    )
                  ],
                ),
        ),
      ],
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime(
      {super.key,
      this.startTime,
      this.endTime,
      required this.onStartChange,
      required this.onEndChange});

  final DateTime? startTime;
  final DateTime? endTime;
  final void Function(DateTime) onStartChange;
  final void Function(DateTime) onEndChange;

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late CreateDolbomContext createContext;

  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    startTime = widget.startTime;
    endTime = widget.endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createContext = context.watch<CreateDolbomContext>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: SelectTimeButton(
                      onSelect: widget.onStartChange,
                      initValue: widget.startTime,
                      endTime: createContext.endTime)),
              const SizedBox(
                width: 8,
              ),
              const Text("부터")
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                  child: SelectTimeButton(
                onSelect: widget.onEndChange,
                initValue: widget.endTime,
                startTime: createContext.startTime,
              )),
              const SizedBox(
                width: 8,
              ),
              const Text("까지")
            ],
          )
        ],
      ),
    );
  }
}

class SelectSeveralTime extends StatefulWidget {
  const SelectSeveralTime({super.key, required this.timeSlots});

  final List<TimeSlot> timeSlots;

  @override
  State<SelectSeveralTime> createState() => _SelectSeveralTimeState();
}

class _SelectSeveralTimeState extends State<SelectSeveralTime> {
  late CreateDolbomContext createContext;

  @override
  Widget build(BuildContext context) {
    createContext = context.read<CreateDolbomContext>();

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.timeSlots.length,
      itemBuilder: (context, index) {
        TimeSlot timeSlot = widget.timeSlots[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat("MM월 dd일 ").format(timeSlot.date),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            SelectTime(
              startTime: timeSlot.startTime,
              endTime: timeSlot.endTime,
              onStartChange: (dateTime) {
                createContext.notifyChange(() {
                  if (createContext.weeklyRepeat) {
                    createContext.repeatDays[index].startTime = dateTime;
                  } else {
                    createContext.selectedDays[index].startTime = dateTime;
                  }
                });
              },
              onEndChange: (dateTime) {
                createContext.notifyChange(() {
                  if (createContext.weeklyRepeat) {
                    createContext.repeatDays[index].endTime = dateTime;
                  } else {
                    createContext.selectedDays[index].endTime = dateTime;
                  }
                });
              },
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16,
      ),
    );
  }
}

class SelectTimeButton extends StatefulWidget {
  const SelectTimeButton({
    super.key,
    this.initValue,
    this.startTime,
    this.endTime,
    required this.onSelect,
  });

  final DateTime? startTime;
  final DateTime? endTime;
  final void Function(DateTime) onSelect;
  final DateTime? initValue;

  @override
  State<SelectTimeButton> createState() => _SelectTimeButtonState();
}

class _SelectTimeButtonState extends State<SelectTimeButton> {
  List<DateTime> _timeList = [];
  DateTime? _selectedTime;

  void _generateTimeList() {
    _timeList = [];
    DateTime startTime = widget.startTime?.add(const Duration(minutes: 30)) ??
        DateTime(2024, 1, 1, 7, 0); // 오전 7시
    DateTime endTime = widget.endTime?.subtract(const Duration(minutes: 30)) ??
        DateTime(2024, 1, 1, 22, 0); // 오후 10시
    Duration interval = const Duration(minutes: 30);

    // 30분 간격으로 time list 를 만듦
    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      _timeList.add(startTime);
      startTime = startTime.add(interval);
    }
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  void _showTimePicker() {
    _generateTimeList();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: ListView.builder(
            itemCount: _timeList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_formatTime(_timeList[index])),
                onTap: () {
                  widget.onSelect(_timeList[index]);
                  setState(() {
                    _selectedTime = _timeList[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      onTap: _showTimePicker,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12)),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: Text(
              widget.initValue != null
                  ? _formatTime(widget.initValue!)
                  : _selectedTime != null
                      ? _formatTime(_selectedTime!)
                      : "시간 선택",
              textAlign: TextAlign.center,
            )),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}
