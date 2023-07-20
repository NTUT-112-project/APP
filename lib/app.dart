import 'package:flutter/material.dart';
import 'package:school_project/ui/login_page.dart';
import 'package:school_project/ui/register_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      initialRoute: '/login',
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => Placeholder(),
      },
    );
  }
}