import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../textures/glassmorphism.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState()=>_HomePage();
}
class _HomePage extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white
              ),
            ),
            const SizedBox(height: 50,),
            TextButton(
              onPressed: (){
                Navigator.popAndPushNamed(context, '/login');
              },
              child: const Text(
                "Sign in",
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),
            ),

            TextButton(
              onPressed: (){
                Navigator.popAndPushNamed(context, '/register');
              },
              child: const Text(
                "Sign up",
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

}