import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:developer';
import '../api/user/user.dart';

class UserStorage {
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
      log("read successful data: $user");
      return user;
    } catch (e) {
      log("error $e");
      return User('','','');
    }
  }

  Future<File> writeUser(User user) async {
    final file = await _localFile;
    log('trying to write user $user');
    return file.writeAsString(jsonEncode(user.toJson()));
  }
}