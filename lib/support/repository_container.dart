
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/repository/auth_repository.dart';
import 'package:slost_only1/repository/dolbom_notice_repository.dart';
import 'package:slost_only1/repository/impl/auth_repository_impl.dart';
import 'package:slost_only1/repository/mock/dolbom_notice_repository_mock.dart';
import 'package:slost_only1/repository/secure_storage.dart';
import 'package:slost_only1/support/http_request_interceptor.dart';

class RepositoryContainer {
  late final AuthRepository authRepository;
  late final DolbomNoticeRepository dolbomNoticeRepository;

  RepositoryContainer._internal();

  void initialize(SecureStorage secureStorage) {
    TokenInterceptor interceptor = TokenInterceptor(secureStorage);
    ContentTypeInterceptor contentTypeInterceptor = ContentTypeInterceptor();
    Client client = InterceptedClient.build(
        interceptors: [contentTypeInterceptor], client: Client());
    Client interceptedClient = InterceptedClient.build(
        interceptors: [contentTypeInterceptor, interceptor], client: Client());
    authRepository = AuthRepositoryImpl(client, interceptedClient);
    dolbomNoticeRepository = DolbomNoticeRepositoryMock();
    interceptor.authRepository = authRepository;
  }

  static final RepositoryContainer _instance = RepositoryContainer._internal();

  factory RepositoryContainer() {
    return _instance;
  }
}
