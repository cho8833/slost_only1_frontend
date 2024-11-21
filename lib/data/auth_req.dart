import 'package:json_annotation/json_annotation.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:slost_only1/enums/auth_service_provider.dart';
import 'package:slost_only1/enums/member_role.dart';

part 'auth_req.g.dart';

@JsonSerializable(createFactory: false)
class SignUpReq {
  String phoneNumber;

  AuthServiceProvider authProvider;

  MemberRole role;

  OAuthToken? kakaoToken;

  SignUpReq(this.phoneNumber, this.authProvider, this.kakaoToken, this.role);

  Map<String, dynamic> toJson() => _$SignUpReqToJson(this);
}

@JsonSerializable(createFactory: false)
class SignInReq {

  AuthServiceProvider authProvider;

  MemberRole role;

  OAuthToken? kakaoToken;

  SignInReq(this.authProvider, this.role, this.kakaoToken);

  Map<String, dynamic> toJson() => _$SignInReqToJson(this);
}