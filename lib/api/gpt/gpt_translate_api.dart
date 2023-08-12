import 'dart:convert';

import '../route.dart';
import '../Controller.dart';
import 'gpt_translate.dart';

class GptTranslateApi{
  final String port=serverUrl;
  final gptTranslate=GptTranslate('','','');
  get http => null;

  Future<Response> translate() async{
    try{
      final response = await http.post(Uri.parse('$port/api/gpt_translate'),body: gptTranslate.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }
  //TODO: implement detectLanguage api on server side
  // Future<Response> detectLanguage()async{
  //   try{
  //     final response = await http.post(Uri.parse('$port/api/user'),body: gptTranslate.toJson());
  //     print("response code: ${response.statusCode}");
  //     return Response.fromJson(jsonDecode(response.body));
  //   }
  //   catch(e){
  //     print(e);
  //     return Response(false, e, 'Exception');
  //   }
  // }
}