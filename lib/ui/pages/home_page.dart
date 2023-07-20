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
                  fontSize: 40,
                  color: Colors.blue
              ),
            ),
          ],
        ),
      ),
    );
  }

}