// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      (json['id'] as num).toInt(),
      json['phoneNumber'] as String?,
      MemberRole.fromJson(json['role'] as String),
      json['sendbirdAccessToken'] as String,
    )..email = json['email'] as String?;

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'role': instance.role,
      'sendbirdAccessToken': instance.sendbirdAccessToken,
    };
