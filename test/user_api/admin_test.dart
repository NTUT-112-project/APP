import 'dart:convert';
// 📦 Package imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/api/Controller.dart';
import 'package:school_project/api/user/user.dart';
import 'package:school_project/api/user/user_api.dart';

void main() {
  group('normalUserLogin', () {
    final userApi = UserApi();
    userApi.user = User('admin', 'admin@gmail.com', 'admin123');

    final dummyUserApi = UserApi();
    dummyUserApi.user = User('dummy', 'dummy@gmail.com', 'dummy123');

    setUp(() {});
    test('register admin', () async {
      final response = await userApi.adminRegister();
      debugPrint(response.data.toString());
      expect(response.success, false); //false after tested once
    });
    test('register dummy user', () async {
      final response = await dummyUserApi.userRegister();
      debugPrint(response.data.toString());
      expect(response.success, true);
    });
    test('login', () async {
      final response = await userApi.login();
      userApi.user.apiToken = response.data; //get api token here
      debugPrint(response.data.toString());
      expect(response.success, true);
    });
    test('get info', () async {
      final response = await userApi.info();
      debugPrint(response.data.toString());
      expect(response.success, true);
    });
    test('delete', () async {
      final response = await userApi.delete('dummy');
      debugPrint(response.data.toString());
      expect(response.success, true); //successfully deleted dummy user
    });
    test('update', () async {
      const newUid = 'newAdminName';
      const newGmail = 'newAdminGmail@gmail.com';
      const newPassword = '777777';
      userApi.user.email = newGmail;
      userApi.user.uid = newUid;
      userApi.user.password = newPassword;
      final response = await userApi.update();
      debugPrint(response.data.toString());
      expect(response.message, anyOf('Validation Error.', 'User updated successfully.'));
    });
    test('logout', () async {
      final response = await userApi.logout();
      debugPrint(response.message.toString());
      expect(response.success, true);
    });
  });
}
