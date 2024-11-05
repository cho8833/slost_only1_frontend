// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DolbomLocation _$DolbomLocationFromJson(Map<String, dynamic> json) =>
    DolbomLocation(
      (json['id'] as num).toInt(),
      Member.fromJson(json['member'] as Map<String, dynamic>),
      Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DolbomLocationToJson(DolbomLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member': instance.member,
      'address': instance.address,
    };
