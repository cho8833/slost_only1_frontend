// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DolbomTimeSlot _$DolbomTimeSlotFromJson(Map<String, dynamic> json) =>
    DolbomTimeSlot(
      DateTime.parse(json['startDateTime'] as String),
      DateTime.parse(json['endDateTime'] as String),
      DolbomTimeSlotStatus.fromJson(json['status'] as String),
      json['isModified'] as bool,
    );

Map<String, dynamic> _$DolbomTimeSlotToJson(DolbomTimeSlot instance) =>
    <String, dynamic>{
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
      'status': instance.status,
      'isModified': instance.isModified,
    };
