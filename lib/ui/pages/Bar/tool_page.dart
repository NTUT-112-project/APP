import 'package:flutter/material.dart';

class ToolPage extends StatefulWidget{
  const ToolPage({super.key});

  @override
  State<StatefulWidget> createState()=>_ToolPage();
}
class _ToolPage extends State<ToolPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tool'),
          centerTitle:true
      ),
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ],
        ),
      ),
    );
  }

}