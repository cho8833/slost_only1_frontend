import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/enums/dolbom_time_slot_status.dart';

part 'dolbom_time_slot.g.dart';

@JsonSerializable()
class DolbomTimeSlot {
  DateTime startDateTime;
  DateTime endDateTime;
  DolbomTimeSlotStatus status;
  bool isModified;

  DolbomTimeSlot(
      this.startDateTime, this.endDateTime, this.status, this.isModified);

  Map<String, dynamic> toJson() => _$DolbomTimeSlotToJson(this);

  factory DolbomTimeSlot.fromJson(Map<String, dynamic> json) => _$DolbomTimeSlotFromJson(json);
}