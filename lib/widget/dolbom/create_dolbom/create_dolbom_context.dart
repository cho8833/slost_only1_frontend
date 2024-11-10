import 'package:flutter/material.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/model/enums/day_of_week.dart';
import 'package:slost_only1/model/enums/dolbom_category.dart';
import 'package:slost_only1/model/kid.dart';

class CreateDolbomContext extends ChangeNotifier {
  List<Kid> kids = [];
  DolbomLocation? dolbomLocation;
  DolbomCategory? category;
  List<TimeSlot> _selectedDays = [];
  DateTime? _startTime;
  DateTime? _endTime;
  bool _isWeeklyRepeat = false;
  bool setSeveralTime = false;

  // 반복 일정 관련 속성
  DateTime? repeatStartDate;
  DateTime? repeatEndDate;
  List<TimeSlot> repeatDays = [];
  List<DayOfWeek> repeatDows = [];

  void notifyChange(void Function() change) {
    change();
    notifyListeners();
  }

  DateTime? get startTime => _startTime;

  List<TimeSlot> get selectedDays => _selectedDays;

  set selectedDays(List<TimeSlot> value) {
    _selectedDays = value;
    for (TimeSlot day in value) {
      day.startTime = startTime;
      day.endTime = endTime;
    }
    notifyListeners();
  }

  bool get isWeeklyRepeat => _isWeeklyRepeat;

  set isWeeklyRepeat(bool value) {
    _isWeeklyRepeat = value;
    notifyListeners();
  }

  DateTime? get endTime => _endTime;

  set endTime(DateTime? value) {
    _endTime = value;
    if (_selectedDays.isNotEmpty) {
      for (TimeSlot day in _selectedDays) {
        day.endTime = endTime;
      }
    }
    notifyListeners();
  }

  set startTime(DateTime? value) {
    _startTime = value;
    if (_selectedDays.isNotEmpty) {
      for (TimeSlot day in _selectedDays) {
        day.startTime = startTime;
      }
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
