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
      'pageNumber': instance.pageNumber,
    };

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
