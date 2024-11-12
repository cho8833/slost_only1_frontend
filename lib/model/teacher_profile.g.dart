// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherProfile _$TeacherProfileFromJson(Map<String, dynamic> json) =>
    TeacherProfile(
      (json['id'] as num).toInt(),
      json['name'] as String,
      Gender.fromJson(json['gender'] as String),
      json['profileImageUrl'] as String,
      DateTime.parse(json['birthday'] as String),
      json['profileName'] as String,
    );

Map<String, dynamic> _$TeacherProfileToJson(TeacherProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'profileImageUrl': instance.profileImageUrl,
      'birthday': instance.birthday.toIso8601String(),
      'profileName': instance.profileName,
    };
