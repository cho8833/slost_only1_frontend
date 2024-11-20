import 'package:json_annotation/json_annotation.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:slost_only1/enums/auth_service_provider.dart';
import 'package:slost_only1/enums/member_role.dart';

part 'sign_in_req.g.dart';

@JsonSerializable(createFactory: false)
class SignInReq {
  String phoneNumber;

  AuthServiceProvider authProvider;

  MemberRole role;

  OAuthToken? kakaoToken;

  SignInReq(this.phoneNumber, this.authProvider, this.kakaoToken, this.role);

  Map<String, dynamic> toJson() => _$SignInReqToJson(this);
}