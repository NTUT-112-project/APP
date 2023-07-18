import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Api{
  static const String port='http://192.168.0.14:8000';

  Future<String> fetchHello() async {
    try{
      final response = await http
          .get(Uri.parse('$port/hello'));
      print("response code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load Hello');
      }
    }
    catch(e){
      print(e);
      return '';
    }
  }

  Future<String> register(User user) async{

    try{
      final response = await http.post(Uri.parse('$port/api/user'),body: user.toJson());
      print("response code: ${response.statusCode}");
      return response.body;
    }
    catch(e){
      print(e);
      return '';
    }
  }
}
class User{
  final String uid;
  final String email;
  final String password;

  User(this.uid, this.email, this.password);

  factory User.fromJson(dynamic json){
    return User(json['uid'] as String,
        json['email'] as String,
        json['password'] as String);
  }
  Map toJson(){
    return {
      'uid' : uid,
      'email' : email,
      'password' : password
    };
  }
  @override
  String toString() {
    return '{ $uid, $email,$password }';
  }
}


void main() {
  runApp(const MyApp());
}

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
  Future<String>? futureHello;
  Future<String>? futureRegister;
  final api=Api();
  final user=User('James','jamesabcde277@gmail.com','123456789');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    futureHello=api.fetchHello();
    futureRegister=api.register(user);
    print(user.toJson());
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Widget registerTest(){
    return SizedBox(
      width:  300,
      height: 200,
      child:
      FutureBuilder<String>(
        future: futureRegister,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!,
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
            // SizedBox(
            //   width: 100,
            //   height: 100,
            //   child:FutureBuilder<String>(
            //     future: futureHello,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text(snapshot.data!);
            //       } else if (snapshot.hasError) {
            //         return Text('${snapshot.error}');
            //       }
            //
            //       // By default, show a loading spinner.
            //       return const CircularProgressIndicator();
            //     },
            //   ),
            // ),
            registerTest(),
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
