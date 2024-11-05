// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DolbomNotice _$DolbomNoticeFromJson(Map<String, dynamic> json) => DolbomNotice(
      (json['id'] as num).toInt(),
      (json['pay'] as num).toInt(),
      DateTime.parse(json['startDateTime'] as String),
      DateTime.parse(json['endDateTime'] as String),
      Member.fromJson(json['member'] as Map<String, dynamic>),
      Kid.fromJson(json['kid'] as Map<String, dynamic>),
      DolbomLocation.fromJson(json['dolbomLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DolbomNoticeToJson(DolbomNotice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pay': instance.pay,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
      'member': instance.member,
      'kid': instance.kid,
      'dolbomLocation': instance.dolbomLocation,
    };
