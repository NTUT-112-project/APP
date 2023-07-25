import 'package:flutter/material.dart';
import 'package:school_project/api/provider/auth_provider.dart';
import 'package:school_project/storage/storage.dart';
import 'package:school_project/ui/pages/home_page.dart';
import 'package:school_project/ui/pages/login_page.dart';

class RootPage extends StatefulWidget{
  const RootPage({super.key});
  @override
  State<StatefulWidget> createState() => _RootPage();
}
class _RootPage extends State<RootPage>{
  bool isSignedIn=false;
  Future<void> autoSignIn(BuildContext context) async {//try to sign in with local stored account
    final userStorage=UserStorage();
    final userApi=AuthProvider.of(context).userApi;
    userApi.user=await userStorage.readUser();
    final response=await userApi.login();
    print(response);
    setState(() {
      isSignedIn=response.success;
    });
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    autoSignIn(context);
  }
  @override
  Widget build(BuildContext context) {
    return (isSignedIn)? const HomePage():const LoginPage();
  }

}