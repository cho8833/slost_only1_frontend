// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_notice_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$DolbomNoticeListReqToJson(
        DolbomNoticeListReq instance) =>
    <String, dynamic>{
      'sido': instance.sido,
      'sigungu': instance.sigungu,
      'bname': instance.bname,
    };

DolbomNoticeCreateReq _$DolbomNoticeCreateReqFromJson(
        Map<String, dynamic> json) =>
    DolbomNoticeCreateReq(
      DateTime.parse(json['startDateTime'] as String),
      DateTime.parse(json['endDateTime'] as String),
      (json['memberId'] as num).toInt(),
      (json['dolbomLocationId'] as num).toInt(),
      (json['kidId'] as num).toInt(),
      (json['pay'] as num).toInt(),
    );

Map<String, dynamic> _$DolbomNoticeCreateReqToJson(
        DolbomNoticeCreateReq instance) =>
    <String, dynamic>{
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
      'memberId': instance.memberId,
      'dolbomLocationId': instance.dolbomLocationId,
      'kidId': instance.kidId,
      'pay': instance.pay,
    };
