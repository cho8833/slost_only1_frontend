// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dolbom _$DolbomFromJson(Map<String, dynamic> json) => Dolbom(
      (json['id'] as num).toInt(),
      Dolbom._timeFromJson(json['startTime'] as String),
      Dolbom._timeFromJson(json['endTime'] as String),
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      json['weeklyRepeat'] as bool,
      json['name'] as String?,
      DolbomCategory.fromJson(json['category'] as String),
      DolbomStatus.fromJson(json['status'] as String),
      (json['kids'] as List<dynamic>)
          .map((e) => Kid.fromJson(e as Map<String, dynamic>))
          .toList(),
      DolbomLocation.fromJson(json['dolbomLocation'] as Map<String, dynamic>),
      (json['dayOfWeeks'] as List<dynamic>?)
          ?.map((e) => DayOfWeek.fromJson(e as String))
          .toList(),
      (json['timeSlots'] as List<dynamic>)
          .map((e) => DolbomTimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['pay'] as num).toInt(),
    );

Map<String, dynamic> _$DolbomToJson(Dolbom instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'weeklyRepeat': instance.weeklyRepeat,
      'name': instance.name,
      'category': instance.category,
      'status': instance.status,
      'kids': instance.kids,
      'dolbomLocation': instance.dolbomLocation,
      'dayOfWeeks': instance.dayOfWeeks,
      'timeSlots': instance.timeSlots,
      'pay': instance.pay,
    };
