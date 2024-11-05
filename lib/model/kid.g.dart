// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kid _$KidFromJson(Map<String, dynamic> json) => Kid(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['age'] as num).toInt(),
      Gender.fromJson(json['gender'] as String),
      json['other'] as String,
    );

Map<String, dynamic> _$KidToJson(Kid instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'other': instance.other,
    };
