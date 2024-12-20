import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_project/api/user/user.dart';

import '../../storage/storage.dart';
import '../Controller.dart';
import '../route.dart';

class UserApi {
  final String port = serverUrl;
  User user = User('', '', '');

  Future<Response> userRegister() async {
    try {
      final response = await http.post(Uri.parse('$port/api/userSignUp'), body: user.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return Response(false, e, 'Exception');
    }
  }

  Future<Response> adminRegister() async {
    try {
      final response = await http.post(Uri.parse('$port/api/adminSignUp'), body: user.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return Response(false, e, 'Exception');
    }
  }

  Future<Response> login() async {
    try {
      final response = await http.post(Uri.parse('$port/api/signIn'), body: user.toJson());
      print("response code: ${response.statusCode}");
      final formatResponse = Response.fromJson(jsonDecode(response.body));
      if (formatResponse.success) {
        user.apiToken = formatResponse.data;
        UserStorage.instance.setApiToken(formatResponse.data as String);
      }
      return formatResponse;
    } catch (e) {
      print(e);
      return Response(false, e, 'Exception');
    }
  }

  Future<Response> info() async {
    try {
      // print('token=${user.apiToken}');
      // print('$port/api/user?api_token=${user.apiToken}');
      final response = await http.get(Uri.parse('$port/api/user?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return Response(false, e, 'Exception');
    }
  }

  Future<Response> update() async {
    try {
      final response = await http.put(Uri.parse('$port/api/user?api_token=${user.apiToken}'), body: user.toJson());
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return Response(false, e, 'Exception');
    }
  }

  Future<Response> delete(String uid) async {
    try {
      final response = await http.delete(Uri.parse('$port/api/user/$uid?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return Response(false, e, 'Exception');
    }
  }

  Future<Response> logout() async {
    try {
      print('$port/api/logout?api_token=${user.apiToken}');
      final response = await http.get(Uri.parse('$port/api/logout?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return Response.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return Response(false, e, 'Exception');
    }
  }
}
