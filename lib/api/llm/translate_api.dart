import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../route.dart';
import '../Controller.dart';
import 'translate.dart';

class TranslateApi {
  final String port = serverUrl;
  Translate translate = Translate('', '', '', '', '');
  Future<Response> getTranslateResult() async {
    try {
      final response = await http
          .post(Uri.parse('$port/api/translate'), body: translate.toJson())
          .timeout(const Duration(seconds: 3));
      print("response code: ${response.statusCode}");
      log(response.body);
      return Response.fromJson(jsonDecode(response.body));
    } on TimeoutException catch (e) {
      return Response(false, e, 'Timeout');
    } on Exception catch (e) {
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
