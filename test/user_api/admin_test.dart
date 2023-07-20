
import 'dart:convert';
// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/api/Controller.dart';
import 'package:school_project/api/user/user.dart';
import 'package:school_project/api/user/user_api.dart';

void main() {
  group('normalUserLogin',(){
    final user=User('admin','admin@gmail.com','admin123');
    final dummyUser=User('dummy','dummy@gmail.com','dummy123');
    final userApi=UserApi();

    setUp(() {

    });
    test('register admin', () async {
      final response=await userApi.adminRegister(user);
      print(response.data);
      expect(response.success, true);
    });
    test('register dummy user', () async {
      final response=await userApi.userRegister(dummyUser);
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
      final response = await userApi.delete(user,'dummy');
      print(response.data);
      expect(response.success, true);//successfully deleted dummy user
    });
    test('update',()async {
      const newUid='newAdminName';
      const newGmail='newAdminGmail@gmail.com';
      user.email=newGmail;
      user.uid=newUid;
      final response = await userApi.update(user);
      print(response.data);
      expect(response.message, anyOf('Validation Error.','User updated successfully.'));
    });
    test('logout',()async{
      final response = await userApi.logout(user);
      print(response.message);
      expect(response.success,true);
    });
  });

}
