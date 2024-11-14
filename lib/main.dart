import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:slost_only1/enums/member_role.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/provider/certificate_provider.dart';
import 'package:slost_only1/provider/dolbom_location_provider.dart';
import 'package:slost_only1/provider/parent_dolbom_provider.dart';
import 'package:slost_only1/provider/kid_provider.dart';
import 'package:slost_only1/provider/teacher_dolbom_provider.dart';
import 'package:slost_only1/provider/teacher_profile_provider.dart';
import 'package:slost_only1/provider/token_provider.dart';
import 'package:slost_only1/repository/impl/secure_storage_impl.dart';
import 'package:slost_only1/repository/secure_storage.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/support/secret_key.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/widget/home/home_screen.dart';
import 'package:slost_only1/widget/auth/login_screen.dart';
import 'package:slost_only1/widget/parent/parent_my_page_screen.dart';
import 'package:slost_only1/widget/parent/parent_main_screen.dart';
import 'package:slost_only1/widget/teacher/teacher_main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthRepository.initialize(
      appKey: SecretKey.kakaoSDKJavascriptKey, baseUrl: "http://localhost");

  final SecureStorage secureStorage =
      SecureStorageImpl(const FlutterSecureStorage());

  // token provider
  TokenProvider tokenProvider = TokenProvider();
  tokenProvider.secureStorage = secureStorage;

  // repository container
  RepositoryContainer rc = RepositoryContainer();
  rc.initialize(secureStorage);

  // auth provider
  AuthProvider authProvider = AuthProvider();
  authProvider.init(rc.authRepository);

  await authProvider.checkSignIn();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final RepositoryContainer rc = RepositoryContainer();
    AuthProvider authProvider = AuthProvider();

    return MultiProvider(
      providers: [
        Provider(
            create: (context) => CertificateProvider(rc.certificateRepository)),
        Provider(create: (context) => ParentDolbomProvider(rc.dolbomRepository)),
        Provider(create: (context) => KidProvider(rc.kidRepository)),
        Provider(
            create: (context) =>
                DolbomLocationProvider(rc.dolbomLocationRepository)),
        Provider(
            create: (context) =>
                TeacherProfileProvider(rc.teacherProfileRepository)),
        Provider(create: (context) => TeacherDolbomProvider(rc.dolbomRepository)),
      ],
      builder: (context, _) => MaterialApp(
          home: authProvider.me != null
              ? authProvider.me!.role == MemberRole.parent
                  ? const ParentMainScreen()
                  : const TeacherMainScreen()
              : const LoginScreen()),
    );
  }
}