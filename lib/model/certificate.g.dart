// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Certificate _$CertificateFromJson(Map<String, dynamic> json) => Certificate(
      (json['id'] as num).toInt(),
      json['title'] as String,
    );

Map<String, dynamic> _$CertificateToJson(Certificate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
