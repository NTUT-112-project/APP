import 'package:flutter/material.dart';
import 'package:android_window/main.dart' as android_window;




class ToolPage extends StatefulWidget{
  const ToolPage({super.key});

  @override
  State<StatefulWidget> createState()=>_ToolPage();
}
class _ToolPage extends State<ToolPage>{
  bool isWindowRunning=false;
  @override
  Widget build(BuildContext context) {
    android_window.setHandler((name, data) async {
      switch (name) {
        case 'hello':
          return 'hello android window';
      }
      return null;
    });
    Color getColor(Set<MaterialState> states) {
      if (isWindowRunning) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT translator'),
          centerTitle:true
      ),
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ElevatedButton(
              style:ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor)
              ),
              onPressed: () => android_window.open(
                size: const Size(400, 400),
                position: const Offset(10000,10000),
              ),
              child: const Text('Activate Translator'),
            ),
          ],
        ),
      ),
    );
  }

}