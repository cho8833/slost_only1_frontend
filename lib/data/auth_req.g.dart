// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SignUpReqToJson(SignUpReq instance) => <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'authProvider': instance.authProvider,
      'role': instance.role,
      'kakaoToken': instance.kakaoToken,
      'appleCredential': serializeAppleCredential(instance.appleCredential),
    };

Map<String, dynamic> _$SignInReqToJson(SignInReq instance) => <String, dynamic>{
      'authProvider': instance.authProvider,
      'role': instance.role,
      'kakaoToken': instance.kakaoToken,
      'appleCredential': serializeAppleCredential(instance.appleCredential),
    };
