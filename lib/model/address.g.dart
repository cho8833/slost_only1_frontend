// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['address'] as String,
      json['sido'] as String,
      json['sigungu'] as String,
      json['bname'] as String,
      json['details'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address': instance.address,
      'sido': instance.sido,
      'sigungu': instance.sigungu,
      'bname': instance.bname,
      'details': instance.details,
    };
