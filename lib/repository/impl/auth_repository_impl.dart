import 'dart:convert';
import 'package:http/http.dart';
import 'package:slost_only1/data/authorization_token_res.dart';
import 'package:slost_only1/data/sign_in_req.dart';
import 'package:slost_only1/data/sign_up_req.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/repository/auth_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/secret_key.dart';
import 'package:slost_only1/support/server_uri.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AuthRepositoryImpl with HttpResponseHandler, ServerUri implements AuthRepository {
  AuthRepositoryImpl(this.client, this.interceptedClient);

  final Client interceptedClient;

  final Client client;

  @override
  Future<AuthorizationTokenRes> signInWithKakaoTalk() async {
    late OAuthToken token;
    if (await isKakaoTalkInstalled()) {
      token = await UserApi.instance.loginWithKakaoTalk(
        nonce: SecretKey.kakaoNonce
      );
    } else {
      token = await UserApi.instance.loginWithKakaoAccount(
        nonce: SecretKey.kakaoNonce
      );
    }

    Uri uri = getUri("/auth/signin/kakao");

    Response response = await client.post(uri, body: jsonEncode(token.toJson()));

    return getData(response, (p0) => AuthorizationTokenRes.fromJson(p0)).data;
  }

  @override
  Future<AuthorizationTokenRes> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
    ]);


    throw Exception();
  }

  @override
  Future<AuthorizationTokenRes> signInWithIdPw({SignInReq? req}) async {
    Uri uri = getUri("/auth/signIn/idpw");

    Response response = await client.post(uri, body: jsonEncode(req?.toJson()));

    return getData(response, (p0) => AuthorizationTokenRes.fromJson(p0)).data;
  }

  @override
  Future<Member> getUserInfo() async {
    Uri uri = getUri("/auth/me");

    Response response = await interceptedClient.get(uri);


    return getData(response, (p0) => Member.fromJson(p0)).data;
  }
  @override
  Future<AuthorizationTokenRes> reissue(
      String accessToken, String refreshToken) async {
    Uri uri = getUri("/auth/token");

    Map<String, String> header = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
      "accessToken": accessToken,
      "refreshToken": refreshToken
    };
    Response response =
    await client.post(uri, headers: header, body: jsonEncode(reqBody));

    return getData(response, (p0) => AuthorizationTokenRes.fromJson(p0)).data;
  }

  @override
  Future<AuthorizationTokenRes> signUp(SignUpReq req) async {
    Uri uri = getUri("/auth/signUp");

    Response response = await client.post(uri, body: jsonEncode(req.toJson()));
    return getData(response, (p0) => AuthorizationTokenRes.fromJson(p0)).data;
  }
}