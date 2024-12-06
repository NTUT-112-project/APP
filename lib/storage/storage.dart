import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../api/user/user.dart';

class UserStorage {
  UserStorage._();

  factory UserStorage() => _instance;
  static final _instance = UserStorage._();

  static UserStorage get instance => _instance;

  String _apiToken = '';
  String get apiToken => _apiToken;
  void setApiToken(String token) {
    _apiToken = token;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.json');
  }

  Future<User> readUser() async {
    try {
      final file = await _localFile;
      final user = User.fromJson(jsonDecode(await file.readAsString()));
      print("read successful data: $user");
      return user;
    } catch (e) {
      print("error $e");
      return User('', '', '');
    }
  }

  Future<File> writeUser(User user) async {
    final file = await _localFile;
    print('trying to write user $user');
    return file.writeAsString(jsonEncode(user.toJson()));
  }
}
