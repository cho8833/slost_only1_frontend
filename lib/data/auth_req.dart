import 'package:json_annotation/json_annotation.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:slost_only1/enums/auth_service_provider.dart';
import 'package:slost_only1/enums/member_role.dart';

part 'auth_req.g.dart';

@JsonSerializable(createFactory: false)
class SignUpReq {
  String phoneNumber;

  AuthServiceProvider authProvider;

  MemberRole role;

  OAuthToken? kakaoToken;

  @JsonKey(toJson: serializeAppleCredential)
  AuthorizationCredentialAppleID? appleCredential;

  SignUpReq(this.phoneNumber, this.authProvider, this.kakaoToken, this.role);

  Map<String, dynamic> toJson() => _$SignUpReqToJson(this);
}

@JsonSerializable(createFactory: false)
class SignInReq {

  AuthServiceProvider authProvider;

  MemberRole role;

  OAuthToken? kakaoToken;

  @JsonKey(toJson: serializeAppleCredential)
  AuthorizationCredentialAppleID? appleCredential;

  SignInReq(this.authProvider, this.role, this.kakaoToken, this.appleCredential);

  Map<String, dynamic> toJson() => _$SignInReqToJson(this);

}

Map<String, dynamic> serializeAppleCredential(AuthorizationCredentialAppleID? credential) {
  return {
    "userIdentifier": credential?.userIdentifier,
    "givenName": credential?.givenName,
    "familyName": credential?.familyName,
    "authorizationCode": credential?.authorizationCode,
    "email": credential?.email,
    "identityToken": credential?.identityToken,
    "state": credential?.state
  };
}