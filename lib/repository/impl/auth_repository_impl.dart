import 'dart:convert';
import 'package:http/http.dart';
import 'package:slost_only1/data/authorization_token_res.dart';
import 'package:slost_only1/data/auth_req.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/repository/auth_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AuthRepositoryImpl with HttpResponseHandler, ServerUri implements AuthRepository {
  AuthRepositoryImpl(this.client, this.interceptedClient);

  final Client interceptedClient;

  final Client client;

  @override
  Future<AuthorizationTokenRes> signUp(SignUpReq req) async {

    Uri uri = getUri("/auth/sign-up");

    Response response = await client.post(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p0) => AuthorizationTokenRes.fromJson(p0)).data;
  }

  @override
  Future<AuthorizationTokenRes> signIn(SignInReq req) async {
    Uri uri = getUri("/auth/sign-in");

    Response response = await client.post(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p) => AuthorizationTokenRes.fromJson(p)).data;
  }

  @override
  Future<Member> getUserInfo() async {
    Uri uri = getUri("/member/me");

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
  Future<AuthorizationTokenRes> testSignIn(MemberRole role) async {
    Uri uri = getUri("/auth/sign-in/test", queryParameters: {
      "role": role.json
    });

    Response response = await client.post(uri);

    return getData(response, (p) => AuthorizationTokenRes.fromJson(p)).data;
  }

  @override
  Future<void> withdrawal() async {
    Uri uri = getUri("/auth/withdrawal");

    Response response = await interceptedClient.post(uri);

    checkResponse(response);
  }
}