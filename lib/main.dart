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
    final response=await userApi.userRegister(user);
    print(response.message);
  }
  Future<void> adminRegisterTest()async {
    final response=await userApi.adminRegister(user);
    print(response.message);
  }

  Future<void> loginTest()async {
    final response=await userApi.login(user);
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
    final response = await userApi.info(user);
    print(response.message);
  }
  Future<void> deleteTest()async{
    final response = await userApi.delete(user,'3');
    print(response.message);
  }
  Future<void> updateTest()async {
    const newUid='newUid';
    const newGmail='newGmail@gmail.com';
    user.email=newGmail;
    user.uid=newUid;
    final response = await userApi.update(user);
    print(response.message);

  }
  Future<void> logoutTest()async{
    final response = await userApi.logout(user);
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
