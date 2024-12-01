import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart' as sendbird;
import 'package:slost_only1/data/auth_req.dart';
import 'package:slost_only1/data/authorization_token_res.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/provider/token_provider.dart';
import 'package:slost_only1/repository/auth_repository.dart';
import 'package:slost_only1/repository/chat_repository.dart';
import 'package:slost_only1/support/custom_exception.dart';
import 'package:flutter/services.dart';
import 'package:slost_only1/support/secret_key.dart';

class AuthProvider {
  // singleton
  static final AuthProvider _instance = AuthProvider._internal();

  factory AuthProvider() => _instance;

  AuthProvider._internal();

  void init(AuthRepository authRepository, ChatRepository chatRepository) {
    _repository = authRepository;
    _chatRepository = chatRepository;
  }

  late final ChatRepository _chatRepository;
  late final AuthRepository _repository;
  final TokenProvider tokenProvider = TokenProvider();

  ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

  String? errorMessage;

  Member? me;

  OAuthToken? kakaoToken;

  Future<void> signInWithApple() async {
    await _repository.signInWithApple();
  }

  Future<OAuthToken> kakaoOAuth() async {
    try {
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
      return token;
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "CANCELED") {
          throw CustomException("취소되었습니다");
        }
      }
      rethrow;
    }
  }

  Future<void> signIn(SignInReq req) async {
    await _repository.signIn(req).then((data) async {
      await _onSignIn(data);
    });
  }

  Future<void> signUp(SignUpReq req) async {
    await _repository.signUp(req).then((res) async {
      await tokenProvider.storeAccessToken(res.accessToken);
      await tokenProvider.storeRefreshToken(res.refreshToken);
      await _repository.getUserInfo().then((user) {
        me = user;
        isLoggedIn.value = true;
      });
    });
  }

  Future<void> _onSignIn(AuthorizationTokenRes res) async {
    await tokenProvider.storeAccessToken(res.accessToken);
    await tokenProvider.storeRefreshToken(res.refreshToken);
    await _repository.getUserInfo().then((user) {
      me = user;
      _connectSendbird();
    });
    isLoggedIn.value = true;
  }

  Future<void> _connectSendbird() async {
    Member member = me!;
    sendbird.SendbirdChat.connect(member.getSendbirdId(),
        accessToken: member.sendbirdAccessToken)
        .catchError((e) async {
      // Sendbird connect 실패하면 다시 Sendbird User 생성 후 connect
      Member member = await _chatRepository.createSendbirdUser();
      me = member;
      return sendbird.SendbirdChat.connect(member.getSendbirdId(),
          accessToken: member.sendbirdAccessToken);
    });
  }

  Future<void> testSignIn(MemberRole role) async {
    await _repository.testSignIn(role).then((res) async {
      _onSignIn(res);
    }).catchError((e) {
      throw ServerResponseException(e.toString());
    });
  }

  Future<void> signOut() async {
    await tokenProvider.deleteToken();
    me = null;
    isLoggedIn.value = false;
  }

  Future<void> checkSignIn() async {
    await _repository.getUserInfo().then((user) {
      me = user;
      isLoggedIn.value = true;
      _connectSendbird();
    });
  }

  String? validateSignUp(String username, String password) {
    if (username.isEmpty) {
      return "username 을 입력해주세요";
    }
    if (password.isEmpty) {
      return "password 를 입력해주세요";
    }
    return null;
  }

}