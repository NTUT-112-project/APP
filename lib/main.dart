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

  Future<String>? futureHello;

  Future<String>? futureRegister;
  Future<String>? futureLogin;

  Future<String>? futureInfo;
  Future<String>? futureUpdate;
  Future<String>? futureDestroy;
  Future<String>? futureLogout;

  final userApi=UserApi();
  final user=User('James','jamesabcde277@gmail.com','123456789');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureHello=userApi.fetchHello();

    futureRegister=userApi.register(user);
    futureLogin=userApi.login(user);

    futureInfo=userApi.info(user);
    futureUpdate=userApi.update(user);
    futureDestroy=userApi.delete(user,'a');
    futureLogout=userApi.logout(user);
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Widget registerTest(){
    return SizedBox(
        width:  300,
        height: 100,
        child:
        FutureBuilder<String>(
          future: futureRegister,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final response=Response.fromJson(jsonDecode(snapshot.data!));
              print(response.message);
              return Text(
                response.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
    );
  }
  Widget loginTest(){
    return SizedBox(
        width:  300,
        height: 100,
        child:
        FutureBuilder<String>(
          future: futureLogin,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final response=Response.fromJson(jsonDecode(snapshot.data!));
              user.apiToken=response.data['apiToken'];
              print(response.message);
              return Text(
                response.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
    );
  }

  Widget infoTest(){
    return SizedBox(
        width:  300,
        height: 100,
        child:
        FutureBuilder<String>(
          future: futureInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final response=Response.fromJson(jsonDecode(snapshot.data!));
              print(response.data);
              return Text(
                response.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
    );
  }
  Widget updateTest(){
    return SizedBox(
        width:  300,
        height: 100,
        child:
        FutureBuilder<String>(
          future: futureInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final response=Response.fromJson(snapshot.data!);

              return Text(
                response.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
    );
  }
  Widget deleteTest(){
    return SizedBox(
        width:  300,
        height: 100,
        child:
        FutureBuilder<String>(
          future: futureInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final response=Response.fromJson(snapshot.data!);
              return Text(
                response.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
    );
  }
  Widget logoutTest(){
    return SizedBox(
        width:  300,
        height: 100,
        child:
        FutureBuilder<String>(
          future: futureInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final response=Response.fromJson(snapshot.data!);
              return Text(
                response.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              );
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
    );
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
            registerTest(),
            loginTest(),
            infoTest(),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

    );
  }
}
