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
      (json['kid'] as List<dynamic>)
          .map((e) => Kid.fromJson(e as Map<String, dynamic>))
          .toList(),
      DolbomLocation.fromJson(json['dolbomLocation'] as Map<String, dynamic>),
      DolbomCategory.fromJson(json['category'] as String),
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
      'category': instance.category,
    };
