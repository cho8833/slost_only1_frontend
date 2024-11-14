import 'package:flutter/material.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/enums/day_of_week.dart';
import 'package:slost_only1/enums/dolbom_category.dart';
import 'package:slost_only1/model/kid.dart';

class CreateDolbomContext extends ChangeNotifier {
  List<Kid> kids = [];
  DolbomLocation? dolbomLocation;
  DolbomCategory? category;
  List<TimeSlot> _selectedDays = [];
  DateTime? _startTime;
  DateTime? _endTime;
  bool _weeklyRepeat = false;
  bool setSeveralTime = false;
  int? pay;

  // 반복 일정 관련 속성
  DateTime? repeatStartDate;
  DateTime? repeatEndDate;
  List<TimeSlot> _repeatDays = [];
  List<DayOfWeek> repeatDows = [];

  void notifyChange(void Function() change) {
    change();
    notifyListeners();
  }

  DateTime? get startTime => _startTime;

  List<TimeSlot> get selectedDays => _selectedDays;

  List<TimeSlot> get repeatDays => _repeatDays;

  set repeatDays(List<TimeSlot> value) {
    _repeatDays = value;
    notifyListeners();
  }

  set selectedDays(List<TimeSlot> value) {
    _selectedDays = value;
    for (TimeSlot day in value) {
      day.startTime ??= startTime;
      day.endTime ??= endTime;
    }
    notifyListeners();
  }

  bool get weeklyRepeat => _weeklyRepeat;

  set weeklyRepeat(bool value) {
    _weeklyRepeat = value;
    List<TimeSlot> days = _weeklyRepeat ? _repeatDays : _selectedDays;
    for (TimeSlot day in days) {
      day.startTime ??= startTime;
      day.endTime ??= endTime;
    }

    notifyListeners();
  }

  DateTime? get endTime => _endTime;

  set endTime(DateTime? value) {
    _endTime = value;
    List<TimeSlot> days = weeklyRepeat ? _repeatDays : _selectedDays;
    for (TimeSlot day in days) {
      day.endTime = endTime;
    }
    notifyListeners();
  }

  set startTime(DateTime? value) {
    _startTime = value;
    List<TimeSlot> days = weeklyRepeat ? _repeatDays : _selectedDays;
      for (TimeSlot day in days) {
        day.startTime = startTime;
      }
    notifyListeners();
  }

  void calRepeatDays() {
    _repeatDays = [];
    if (repeatStartDate == null) {
      notifyListeners();
      return;
    }
    DateTime currentDate = repeatStartDate!;
    if (repeatEndDate == null) {
      _repeatDays = [TimeSlot.from(repeatStartDate!)];
      notifyListeners();
      return;
    }
    while (currentDate.isBefore(repeatEndDate!) ||
        currentDate.isAtSameMomentAs(repeatEndDate!)) {
      if (repeatDows.contains(DayOfWeek.values[currentDate.weekday - 1])) {
        _repeatDays.add(TimeSlot.from(currentDate));
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    notifyListeners();
  }
}

class TimeSlot {
  DateTime date;
  DateTime? startTime;
  DateTime? endTime;

  TimeSlot(this.date);

  factory TimeSlot.from(DateTime dateTime) {
    return TimeSlot(dateTime);
  }
}
