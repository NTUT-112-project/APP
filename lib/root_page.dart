import 'package:flutter/material.dart';
import 'package:school_project/api/provider/auth_provider.dart';
import 'package:school_project/storage/storage.dart';
import 'package:school_project/ui/pages/home_page.dart';
import 'package:school_project/ui/pages/login_page.dart';
import 'package:chalkdart/chalk.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<StatefulWidget> createState() => _RootPage();
}

enum SignInState { tryingAutoSignIn, autoSignInSucceed, autoSignInFailed }

class _RootPage extends State<RootPage> {
  SignInState signInState = SignInState.tryingAutoSignIn;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autoSignIn(context);
  }


  Future<void> autoSignIn(BuildContext context) async {
    if(signInState!=SignInState.tryingAutoSignIn) return ;
    print(chalk.yellow('trying to auto login with locally stored account and password'));
    //try to sign in with local stored account
    final userStorage = UserStorage();
    final userApi = AuthProvider.of(context).userApi;
    userApi.user = await userStorage.readUser();
    final response = await userApi.login();
    print(response);
    setState(() {
      signInState = response.success
          ? SignInState.autoSignInSucceed
          : SignInState.autoSignInFailed;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (signInState) {
      case SignInState.tryingAutoSignIn:
        return const Center(
          child: SizedBox(
              width: 50, height: 50, child: CircularProgressIndicator(),
          ),
        );
      case SignInState.autoSignInSucceed:
        return const HomePage();
      case SignInState.autoSignInFailed:
        return const LoginPage();
    }
  }
}
