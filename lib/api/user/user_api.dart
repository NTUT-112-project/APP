import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_project/api/user/user.dart';

import '../Controller.dart';


class UserApi{
  static const String port='http://192.168.0.14:8000';

  Future<Response> userRegister(User user) async{
    try{
      final response = await http.post(Uri.parse('$port/api/user'),body: user.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }
  Future<Response> adminRegister(User user) async{
    try{
      final response = await http.post(Uri.parse('$port/api/admin'),body: user.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }
  Future<Response> login(User user) async{
    try{
      final response = await http.post(Uri.parse('$port/api/login'),body: user.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }

  Future<Response> info(User user) async{

    try{
      // print('token=${user.apiToken}');
      // print('$port/api/user?api_token=${user.apiToken}');
      final response = await http.get(Uri.parse('$port/api/user?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }
  Future<Response> update(User user) async{
    try{
      final response = await http.put(Uri.parse('$port/api/user?api_token=${user.apiToken}'),body: user.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }
  Future<Response> delete(User user,String uid) async{
    try{
      final response = await http.delete(Uri.parse('$port/api/user/$uid?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }
  Future<Response> logout(User user) async{
    try{
      final response = await http.get(Uri.parse('$port/api/logout?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    }
    catch(e){
      print(e);
      return Response(false, e, 'Exception');
    }
  }
}
