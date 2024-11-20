import 'package:slost_only1/data/authorization_token_res.dart';
import 'package:slost_only1/data/sign_in_req.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/model/member.dart';

abstract interface class AuthRepository {

  Future<AuthorizationTokenRes> testSignIn(MemberRole role);

  Future<Member> getUserInfo();

  Future<AuthorizationTokenRes> reissue(String accessToken, String refreshToken);

  Future<AuthorizationTokenRes> signInWithKakaoTalk(SignInReq req);

  Future<AuthorizationTokenRes> signInWithApple();


}