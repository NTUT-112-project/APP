import 'package:flutter/material.dart';
import '../user/user_api.dart';

class AuthProvider extends InheritedWidget{
  UserApi userApi;
  AuthProvider(
      {super.key, required this.userApi, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget)=>true;

  static AuthProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider of(BuildContext context) {
    final AuthProvider? result = maybeOf(context);
    assert(result != null, 'No InheritedWidget1 found in context');
    return result!;
  }
}