import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/authorization_token_res.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/provider/token_provider.dart';
import 'package:slost_only1/repository/auth_repository.dart';
import 'package:slost_only1/repository/secure_storage.dart';
import 'package:slost_only1/support/custom_exception.dart';

class TokenInterceptor extends InterceptorContract {
  final SecureStorage secureStorage;
  final TokenProvider tokenProvider = TokenProvider();
  final AuthProvider authProvider = AuthProvider();
  late final AuthRepository _authRepository;

  String? accessToken;

  TokenInterceptor(this.secureStorage);

  set authRepository(AuthRepository repository) {
    _authRepository = repository;
  }

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    String? accessToken = await tokenProvider.accessToken;
    if (accessToken == null || checkJwtExpired(accessToken)) {
      String? refreshToken = await tokenProvider.refreshToken;
      if (refreshToken == null || checkJwtExpired(refreshToken)) {
        authProvider.isLoggedIn.value = false;
        throw ForbiddenException();
      }
      AuthorizationTokenRes res =
          await _authRepository.reissue(accessToken ?? "", refreshToken);
      accessToken = res.accessToken;
      await tokenProvider.storeAccessToken(res.accessToken);
      await tokenProvider.storeRefreshToken(res.refreshToken);
    }
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $accessToken';

    return request;
  }

  bool checkJwtExpired(String accessToken) {
    JWT? jwt = JWT.tryDecode(accessToken);
    Map<String, dynamic> payload = jwt?.payload as Map<String, dynamic>;
    DateTime expireTime =
        DateTime.fromMillisecondsSinceEpoch((payload['exp'] as int) * 1000);
    if (expireTime.isBefore(DateTime.now())) {
      return true;
    }
    return false;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }
}

class ContentTypeInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    request.headers['Content-Type'] = 'application/json';
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    return response;
  }
}
