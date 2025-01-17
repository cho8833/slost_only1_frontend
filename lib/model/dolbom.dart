import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/model/dolbom_time_slot.dart';
import 'package:slost_only1/enums/day_of_week.dart';
import 'package:slost_only1/enums/dolbom_category.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/model/kid.dart';

part 'dolbom.g.dart';

@JsonSerializable()
class Dolbom {
  int id;
  @JsonKey(fromJson: _timeFromJson)
  DateTime? startTime;
  @JsonKey(fromJson: _timeFromJson)
  DateTime? endTime;

  DateTime? startDate;
  DateTime? endDate;
  bool weeklyRepeat;
  String? name;
  DolbomCategory category;
  DolbomStatus status;
  List<Kid> kids;
  DolbomLocation dolbomLocation;
  List<DayOfWeek>? dayOfWeeks;
  List<DolbomTimeSlot> timeSlots;

  int pay;

  Dolbom(
      this.id,
      this.startTime,
      this.endTime,
      this.startDate,
      this.endDate,
      this.weeklyRepeat,
      this.name,
      this.category,
      this.status,
      this.kids,
      this.dolbomLocation,
      this.dayOfWeeks,
      this.timeSlots, this.pay);

  Map<String, dynamic> toJson() => _$DolbomToJson(this);

  factory Dolbom.fromJson(Map<String, dynamic> json) => _$DolbomFromJson(json);

  static DateTime _timeFromJson(String time) {
    return DateTime.parse("1970-01-01T$time");
  }
}