import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_project/storage/storage.dart';

import '../../api/provider/auth_provider.dart';
import '../../api/user/user.dart';
import '../../api/user/user_api.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool isRememberMeChecked = false;
  bool isWrongAccountOrPassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();

  final FocusNode _accountFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _signIn(BuildContext context) async {
    final userApi = AuthProvider.of(context).userApi;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          );
        });
    final response = await userApi.login();
    print(response);

    if (context.mounted) {
      if (response.success) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, '/home');
        if (isRememberMeChecked) {
          UserStorage().writeUser(userApi.user);
        }
      } else {
        Navigator.pop(context);
        setState(() {
          isWrongAccountOrPassword = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthProvider.of(context).userApi.user;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text('Language translation and learning APP based on LLM',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Sign in to APP",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _accountControl,
                      cursorColor: Colors.blue[800],
                      textInputAction: TextInputAction.next,
                      focusNode: _accountFocus,
                      autofillHints: const [AutofillHints.username],
                      onChanged: (String newAccount) {
                        if (newAccount == user.email || newAccount == user.uid) return;
                        setState(() {
                          if (EmailValidator.validate(newAccount)) {
                            user.email = newAccount;
                            user.uid = '';
                          } else {
                            user.uid = newAccount;
                            user.email = '';
                          }
                        });
                      },
                      onEditingComplete: () {
                        _accountFocus.unfocus();
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email or User ID',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordControl,
                      cursorColor: Colors.blue[800],
                      obscureText: true,
                      focusNode: _passwordFocus,
                      autofillHints: const [AutofillHints.password],
                      onChanged: (String newPassword) {
                        if (newPassword == user.password) return;
                        setState(() {
                          user.password = newPassword;
                        });
                      },
                      onEditingComplete: () {
                        _passwordFocus.unfocus();
                        TextInput.finishAutofillContext();
                        setState(() {
                          user.password = _passwordControl.text;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: double.maxFinite,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.blue,
                              value: isRememberMeChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isRememberMeChecked = value!;
                                });
                              },
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 40,
                        width: double.maxFinite,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green[700],
                          ),
                          onPressed: () {
                            _signIn(context);
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    const SizedBox(height: 5),
                    Text(
                      (isWrongAccountOrPassword) ? "*Wrong account or password" : "",
                      style: const TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "No account?",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/register');
              },
              child: const Text(
                "Create one.",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ])
        ],
      )),
    );
  }
}
