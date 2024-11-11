// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$DolbomListReqToJson(DolbomListReq instance) =>
    <String, dynamic>{
      'sido': instance.sido,
      'sigungu': instance.sigungu,
      'bname': instance.bname,
      'status': instance.status,
    };

Map<String, dynamic> _$PostDolbomReqToJson(PostDolbomReq instance) =>
    <String, dynamic>{
      'dolbomLocationId': instance.dolbomLocationId,
      'kidIds': instance.kidIds,
      'pay': instance.pay,
      'timeSlots': instance.timeSlots,
      'category': instance.category,
      'weeklyRepeat': instance.weeklyRepeat,
      'dows': instance.dows,
      'repeatStartDate': instance.repeatStartDate?.toIso8601String(),
      'repeatEndDate': instance.repeatEndDate?.toIso8601String(),
      'setSeveralTime': instance.setSeveralTime,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };

Map<String, dynamic> _$CreateDolbomTimeSlotReqToJson(
        CreateDolbomTimeSlotReq instance) =>
    <String, dynamic>{
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
    };
