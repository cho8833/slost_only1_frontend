
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slost_only1/data/sign_in_req.dart';
import 'package:slost_only1/data/sign_up_req.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/provider/token_provider.dart';
import 'package:slost_only1/repository/auth_repository.dart';
import 'package:slost_only1/support/custom_exception.dart';
import 'package:flutter/services.dart';

class AuthProvider {
  // singleton
  static final AuthProvider _instance = AuthProvider._internal();
  factory AuthProvider() => _instance;
  AuthProvider._internal();

  void init(AuthRepository authRepository) {
    _repository = authRepository;
  }

  late final AuthRepository _repository;
  final TokenProvider tokenProvider = TokenProvider();

  ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

  String? errorMessage;

  Member? me;

  Future<void> signInWithApple() async {
    await _repository.signInWithApple();
  }

  Future<void> signInWithKakaoTalk() async {
    await _repository.signInWithKakaoTalk().then((res) async {
      await tokenProvider.storeAccessToken(res.accessToken);
      await tokenProvider.storeRefreshToken(res.refreshToken);
      await _repository.getUserInfo().then((user) {
        me = user;
      });
      isLoggedIn.value = true;
    }).catchError((e) {
      if (e is PlatformException) {
        if (e.code == "CANCELED") {
          throw CustomException("취소되었습니다");
        }
      }
      throw ServerResponseException(e.toString());
    });

  }

  Future<void> testSignIn(MemberRole role) async {
    await _repository.testSignIn(role).then((res) async {
      await tokenProvider.storeAccessToken(res.accessToken);
      await tokenProvider.storeRefreshToken(res.refreshToken);
      await _repository.getUserInfo().then((user) {
        me = user;
      });
      isLoggedIn.value = true;
    }).catchError((e) {
      throw ServerResponseException(e.toString());
    });
  }

  Future<void> signInIdPw(String username, String password) async {
    SignInReq req = SignInReq(username, password);
    await _repository.signInWithIdPw(req: req).then((res) async {
      await tokenProvider.storeAccessToken(res.accessToken);
      await tokenProvider.storeRefreshToken(res.refreshToken);
      await _repository.getUserInfo().then((user) {
        me = user;
      });
      isLoggedIn.value = true;
    }).catchError((e) {
      throw ServerResponseException(e.toString());
    });
  }

  Future<void> signUp(String username, String password) async {
    String? validate = validateSignUp(username, password);
    if (validate != null) {
      throw ServerResponseException(validate);
    }
    SignUpReq req = SignUpReq(username, password);
    await _repository.signUp(req).then((token) async {
      await tokenProvider.storeAccessToken(token.accessToken);
      await tokenProvider.storeRefreshToken(token.refreshToken);
      await _repository.getUserInfo().then((user) {
        me = user;
      });
      isLoggedIn.value = true;
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
    }).catchError((e) {});
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