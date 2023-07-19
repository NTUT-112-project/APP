import 'dart:convert';

import 'package:flutter/material.dart';
import 'api/Controller.dart';
import 'api/user/user.dart';
import 'api/user/user_api.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool login=false;

  final userApi=UserApi();
  final user=User('james','james@gmail.com','123456789');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userRegisterTest();
    loginTest();
  }

  Future<void> userRegisterTest()async {
    final data=await userApi.userRegister(user);
    final response = Response.fromJson(jsonDecode(data));
    print(response.message);
  }
  Future<void> adminRegisterTest()async {
    final data=await userApi.adminRegister(user);
    final response = Response.fromJson(jsonDecode(data));
    print(response.message);
  }

  Future<void> loginTest()async {
    final data=await userApi.login(user);
    final response = Response.fromJson(jsonDecode(data));
    print(response.message);
    setState(() {
      user.apiToken=response.data;
      infoTest();
      deleteTest();
      updateTest();
      logoutTest();
    });
  }
  Future<void> infoTest()async {
    final data = await userApi.info(user);
    final response = Response.fromJson(jsonDecode(data));
    print(response.message);
  }
  Future<void> deleteTest()async{
    final data = await userApi.delete(user,'3');
    final response = Response.fromJson(jsonDecode(data));
    print(response.message);
  }
  Future<void> updateTest()async {
    const newUid='newUid';
    const newGmail='newGmail@gmail.com';
    user.email=newGmail;
    user.uid=newUid;
    final data = await userApi.update(user);
    final response = Response.fromJson(jsonDecode(data));
    print(response.message);

  }
  Future<void> logoutTest()async{
    final data = await userApi.logout(user);
    final response = Response.fromJson(jsonDecode(data));
    print(response.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
