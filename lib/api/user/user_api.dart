import 'package:http/http.dart' as http;
import 'package:school_project/api/user/user.dart';


class UserApi{
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
  Future<String> login(User user) async{
    try{
      final response = await http.post(Uri.parse('$port/api/login'),body: user.toJson());
      print("response code: ${response.statusCode}");
      return response.body;
    }
    catch(e){
      print(e);
      return '';
    }
  }

  Future<String> info(User user) async{
    try{
      print('token=${user.apiToken}');
      final response = await http.get(Uri.parse('$port/api/user?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return response.body;
    }
    catch(e){
      print(e);
      return '';
    }
  }
  Future<String> update(User user) async{
    try{
      final response = await http.put(Uri.parse('$port/api/user?api_token=${user.apiToken}'),body: user.toJson());
      print("response code: ${response.statusCode}");
      return response.body;
    }
    catch(e){
      print(e);
      return '';
    }
  }
  Future<String> delete(User user,String uid) async{
    try{
      final response = await http.delete(Uri.parse('$port/api/user/$uid?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return response.body;
    }
    catch(e){
      print(e);
      return '';
    }
  }
  Future<String> logout(User user) async{
    try{
      final response = await http.get(Uri.parse('$port/api/logout?api_token=${user.apiToken}'));
      print("response code: ${response.statusCode}");
      return response.body;
    }
    catch(e){
      print(e);
      return '';
    }
  }
}
