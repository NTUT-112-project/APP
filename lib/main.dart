import 'package:flutter/material.dart';
import 'package:school_project/storage/storage.dart';
import 'api/user/user_api.dart';
import 'app.dart';

Future<void> main() async {
  //TODO: replace this feature (auto login) with future builder
  WidgetsFlutterBinding.ensureInitialized();


  final userStorage=UserStorage();
  //try to login with local stored data
  final user=await userStorage.readUser();
  print(user);
  final response=await UserApi().login(user);
  print(response);
  runApp(MyApp(response.success));
}
