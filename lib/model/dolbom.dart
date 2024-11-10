import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/model/dolbom_time_slot.dart';
import 'package:slost_only1/model/enums/day_of_week.dart';
import 'package:slost_only1/model/enums/dolbom_category.dart';
import 'package:slost_only1/model/enums/dolbom_status.dart';
import 'package:slost_only1/model/kid.dart';

part 'dolbom.g.dart';

@JsonSerializable()
class Dolbom {
  DateTime startTime;
  DateTime endTime;
  DateTime startDate;
  DateTime endDate;
  bool weeklyRepeat;
  String name;
  DolbomCategory category;
  DolbomStatus status;
  List<Kid> kids;
  DolbomLocation location;
  List<DayOfWeek>? dayOfWeeks;
  List<DolbomTimeSlot>? timeSlots;

  Dolbom(
      this.startTime,
      this.endTime,
      this.startDate,
      this.endDate,
      this.weeklyRepeat,
      this.name,
      this.category,
      this.status,
      this.kids,
      this.location,
      this.dayOfWeeks,
      this.timeSlots);

  Map<String, dynamic> toJson() => _$DolbomToJson(this);

  factory Dolbom.fromJson(Map<String, dynamic> json) => _$DolbomFromJson(json);
}