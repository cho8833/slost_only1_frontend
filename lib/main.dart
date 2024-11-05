import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/provider/dolbom_notice_provider.dart';
import 'package:slost_only1/provider/token_provider.dart';
import 'package:slost_only1/repository/impl/secure_storage_impl.dart';
import 'package:slost_only1/repository/secure_storage.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/support/secret_key.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/widget/screen/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: SecretKey.kakaoSDKNativeAppKey
  );


  final SecureStorage secureStorage = SecureStorageImpl(const FlutterSecureStorage());

  // token provider
  TokenProvider tokenProvider = TokenProvider();
  tokenProvider.secureStorage = secureStorage;

  // repository container
  RepositoryContainer rc = RepositoryContainer();
  rc.initialize(secureStorage);

  // auth provider
  AuthProvider authProvider = AuthProvider();
  authProvider.init(rc.authRepository);

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final RepositoryContainer rc = RepositoryContainer();
    return MultiProvider(
      providers: [
        Provider(create: (context) => DolbomNoticeProvider(rc.dolbomNoticeRepository))
      ],
      builder: (context, _) => const MaterialApp(
        home: HomeScreen()
      ),
    );
  }
}
