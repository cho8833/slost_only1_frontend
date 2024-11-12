// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableArea _$AvailableAreaFromJson(Map<String, dynamic> json) =>
    AvailableArea(
      (json['id'] as num).toInt(),
      json['sido'] as String,
      json['sigungu'] as String,
    );

Map<String, dynamic> _$AvailableAreaToJson(AvailableArea instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sido': instance.sido,
      'sigungu': instance.sigungu,
    };
