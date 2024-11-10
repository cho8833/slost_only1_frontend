import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/provider/dolbom_location_provider.dart';
import 'package:slost_only1/provider/kid_provider.dart';
import 'package:slost_only1/provider/token_provider.dart';
import 'package:slost_only1/repository/impl/secure_storage_impl.dart';
import 'package:slost_only1/repository/secure_storage.dart';
import 'package:slost_only1/support/repository_container.dart';
import 'package:slost_only1/support/secret_key.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/widget/home/home_screen.dart';
import 'package:slost_only1/widget/kid/manage_kid_screen.dart';
import 'package:slost_only1/widget/login/login_screen.dart';
import 'package:slost_only1/widget/my_page/my_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthRepository.initialize(appKey: SecretKey.kakaoSDKJavascriptKey, baseUrl: "http://localhost");

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
    return MultiProvider(
      providers: [
        Provider(create: (context) => KidProvider(rc.kidRepository)),
        Provider(create: (context) => DolbomLocationProvider(rc.dolbomLocationRepository))
      ],
      builder: (context, _) => MaterialApp(
          home: AuthProvider().isLoggedIn.value ? const MainScreen() : const LoginScreen()),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ManageKidScreen(),
    MyPageScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Kid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'MyPage',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
