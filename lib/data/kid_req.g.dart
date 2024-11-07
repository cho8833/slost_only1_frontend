// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$KidCreateReqToJson(KidCreateReq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthday': instance.birthday.toIso8601String(),
      'gender': instance.gender,
      'tendency': instance.tendency,
      'remark': instance.remark,
    };

Map<String, dynamic> _$KidEditReqToJson(KidEditReq instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthday': instance.birthday.toIso8601String(),
      'gender': instance.gender,
      'tendency': instance.tendency,
      'remark': instance.remark,
    };
