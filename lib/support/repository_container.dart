
import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/repository/auth_repository.dart';
import 'package:slost_only1/repository/dolbom_location_repository.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/repository/impl/DolbomLocationRepositoryImpl.dart';
import 'package:slost_only1/repository/impl/dolbom_repository_impl.dart';
import 'package:slost_only1/repository/impl/kid_repository_impl.dart';
import 'package:slost_only1/repository/impl/auth_repository_impl.dart';
import 'package:slost_only1/repository/kid_repository.dart';
import 'package:slost_only1/repository/secure_storage.dart';
import 'package:slost_only1/support/http_request_interceptor.dart';

class RepositoryContainer {
  late final AuthRepository authRepository;
  late final KidRepository kidRepository;
  late final DolbomLocationRepository dolbomLocationRepository;
  late final DolbomRepository dolbomRepository;

  RepositoryContainer._internal();

  void initialize(SecureStorage secureStorage) {
    TokenInterceptor interceptor = TokenInterceptor(secureStorage);
    ContentTypeInterceptor contentTypeInterceptor = ContentTypeInterceptor();
    Client client = InterceptedClient.build(
        interceptors: [contentTypeInterceptor], client: Client());
    Client interceptedClient = InterceptedClient.build(
        interceptors: [contentTypeInterceptor, interceptor], client: Client());
    authRepository = AuthRepositoryImpl(client, interceptedClient);
    kidRepository = KidRepositoryImpl(interceptedClient);
    dolbomLocationRepository = DolbomLocationRepositoryImpl(interceptedClient);
    dolbomRepository = DolbomRepositoryImpl(interceptedClient);
    interceptor.authRepository = authRepository;
  }

  static final RepositoryContainer _instance = RepositoryContainer._internal();

  factory RepositoryContainer() {
    return _instance;
  }
}
