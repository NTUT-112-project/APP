import 'package:flutter/material.dart';
import 'package:school_project/ui/pages/home_page.dart';

import 'package:school_project/ui/pages/login_page.dart';
import 'package:school_project/ui/pages/register_page.dart';


class MyApp extends StatelessWidget {
  final bool isSignedIn;
  const MyApp(this.isSignedIn, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      initialRoute: isSignedIn?'/home':'/login',
      theme: ThemeData.dark(),
      routes: {
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}