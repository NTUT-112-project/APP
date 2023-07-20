
import 'dart:convert';
// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/api/Controller.dart';
import 'package:school_project/api/user/user.dart';
import 'package:school_project/api/user/user_api.dart';

void main() {
  group('normalUserLogin',(){
    final user=User('user','user@gmail.com','user123');
    final userApi=UserApi();

    setUp(() {

    });
    test('register', () async {
      final response=await userApi.userRegister(user);
      print(response.data);
      expect(response.success, true);
    });
    test('login', () async {
      final response=await userApi.login(user);
      user.apiToken=response.data;//get api token here
      print(response.data);
      expect(response.success, true);
    });
    test('get info', () async {
      final response = await userApi.info(user);
      print(response.data);
      expect(response.success, true);
    });
    test('delete', () async {
      final response = await userApi.delete(user,'3');
      print(response.data);
      expect(response.success, false);//don't have authority
    });
    test('update',()async {
      const newUid='newUserName';
      const newGmail='newUserGmail@gmail.com';
      user.email=newGmail;
      user.uid=newUid;
      final response = await userApi.update(user);
      print(response.message);
      expect(response.message, anyOf('Validation Error.','User updated successfully.'));
    });
    test('logout',()async{
      final response = await userApi.logout(user);
      print(response.message);
      expect(response.success,true);
    });
  });
}
