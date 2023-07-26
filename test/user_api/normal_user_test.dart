
import 'dart:convert';
// 📦 Package imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/api/Controller.dart';
import 'package:school_project/api/provider/auth_provider.dart';
import 'package:school_project/api/user/user.dart';
import 'package:school_project/api/user/user_api.dart';

void main() {
  group('normalUserLogin',(){

    final userApi=UserApi();
    userApi.user=User('user','user@gmail.com','user123');
    setUp(() {

    });
    test('register', () async {
      final response=await userApi.userRegister();
      debugPrint(response.data.toString());
      expect(response.success, false);
    });
    test('login', () async {
      final response=await userApi.login();
      userApi.user.apiToken=response.data;//get api token here
      debugPrint(response.data.toString());
      expect(response.success, true);
    });
    test('get info', () async {
      final response = await userApi.info();
      debugPrint(response.data.toString());
      expect(response.success, true);
    });
    test('delete', () async {
      final response = await userApi.delete('3');
      debugPrint(response.data.toString());
      expect(response.success, false);//don't have authority
    });
    test('update',()async {
      const newUid='newUserName';
      const newGmail='newUserGmail@gmail.com';
      userApi.user.email=newGmail;
      userApi.user.uid=newUid;
      final response = await userApi.update();
      debugPrint(response.message);
      expect(response.message, anyOf('Validation Error.','User updated successfully.'));
    });
    test('logout',()async{
      final response = await userApi.logout();
      debugPrint(response.message);
      expect(response.success,true);
    });
  });
}
