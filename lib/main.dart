import 'package:flutter/material.dart';
import 'package:school_project/root_page.dart';
import 'package:school_project/ui/pages/float_page.dart';
import 'package:school_project/ui/pages/home_page.dart';
import 'package:school_project/ui/pages/login_page.dart';
import 'package:school_project/ui/pages/register_page.dart';
import 'api/provider/auth_provider.dart';
import 'api/user/user_api.dart';

@pragma('vm:entry-point')
void overlayMain() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WindowHomePage(),
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
        userApi: UserApi(),
        child: MaterialApp(routes: {
          '/home': (context) => const HomePage(),
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
        }, title: 'App', theme: ThemeData.dark(), home: const RootPage()));
  }
}
