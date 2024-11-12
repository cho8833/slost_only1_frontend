import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/dolbom_time_slot_status.dart';

part 'dolbom_time_slot.g.dart';

@JsonSerializable()
class DolbomTimeSlot {
  DateTime startDateTime;
  DateTime endDateTime;
  DolbomTimeSlotStatus status;

  DolbomTimeSlot(
      this.startDateTime, this.endDateTime, this.status);

  Map<String, dynamic> toJson() => _$DolbomTimeSlotToJson(this);

  factory DolbomTimeSlot.fromJson(Map<String, dynamic> json) => _$DolbomTimeSlotFromJson(json);
}