import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/day_of_week.dart';
import 'package:slost_only1/enums/dolbom_category.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';

part 'dolbom_req.g.dart';

@JsonSerializable(createFactory: false)
class PostDolbomReq {
  int dolbomLocationId;
  List<int> kidIds;
  int pay;
  List<CreateDolbomTimeSlotReq> timeSlots;
  DolbomCategory category;

  bool weeklyRepeat;
  List<DayOfWeek>? dows; // isWeeklyRepeat == false, null
  DateTime? repeatStartDate; // isWeeklyRepeat == false, null
  DateTime? repeatEndDate; // isWeeklyRepeat == false, null

  bool setSeveralTime;
  DateTime? startTime; // setSeveralTime == True, null
  DateTime? endTime; // setSeveralTime == True, null

  PostDolbomReq(this.dolbomLocationId,
      this.kidIds,
      this.pay,
      this.timeSlots,
      this.category,
      this.weeklyRepeat,
      this.dows,
      this.repeatStartDate,
      this.repeatEndDate,
      this.setSeveralTime,
      this.startTime,
      this.endTime);


  factory PostDolbomReq.from(CreateDolbomContext context) {
    List<TimeSlot> days = context.weeklyRepeat ? context.repeatDays : context.selectedDays;
    return PostDolbomReq(
        context.dolbomLocation!.id,
        context.kids.map((kid) => kid.id).toList(),
        context.pay!,
        days.map((day) => CreateDolbomTimeSlotReq.from(day)).toList(),
        context.category!,
        context.weeklyRepeat,
        context.weeklyRepeat ? context.repeatDows : null,
        context.repeatStartDate,
        context.repeatEndDate,
        context.setSeveralTime,
        context.startTime,
        context.endTime);
  }

  Map<String, dynamic> toJson() => _$PostDolbomReqToJson(this);
}

@JsonSerializable(createFactory: false)
class CreateDolbomTimeSlotReq {
  DateTime startDateTime;
  DateTime endDateTime;

  CreateDolbomTimeSlotReq(this.startDateTime, this.endDateTime);

  factory CreateDolbomTimeSlotReq.from(TimeSlot timeSlot) {
    return CreateDolbomTimeSlotReq(DateTime(
        timeSlot.date.year, timeSlot.date.month, timeSlot.date.day,
        timeSlot.startTime!.hour, timeSlot.startTime!.minute),
        DateTime(timeSlot.date.year, timeSlot.date.month, timeSlot.date.day,
            timeSlot.endTime!.hour, timeSlot.endTime!.minute));
  }

  Map<String, dynamic> toJson() => _$CreateDolbomTimeSlotReqToJson(this);
}