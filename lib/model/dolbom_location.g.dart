// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DolbomLocation _$DolbomLocationFromJson(Map<String, dynamic> json) =>
    DolbomLocation(
      (json['id'] as num).toInt(),
      Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DolbomLocationToJson(DolbomLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
    };
