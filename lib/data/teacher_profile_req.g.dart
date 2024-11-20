// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_profile_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TeacherProfileCreateReqToJson(
        TeacherProfileCreateReq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'birthday': instance.birthday?.toIso8601String(),
      'profileName': instance.profileName,
      'pay': instance.pay,
      'availableArea': instance.availableArea,
    };

Map<String, dynamic> _$TeacherProfileEditReqToJson(
        TeacherProfileEditReq instance) =>
    <String, dynamic>{
      'introduce': instance.introduce,
      'howBecameTeacher': instance.howBecameTeacher,
    };
