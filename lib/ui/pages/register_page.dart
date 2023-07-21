import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/user/user.dart';
import '../../api/user/user_api.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState()=>_RegisterPage();
}
class _RegisterPage extends State<RegisterPage>{
  String uidInvalidMessage='';
  String emailInvalidMessage='';
  String passwordInvalidMessage='';
  String confirmPasswordInvalidMessage='';

  bool passwordConfirmCorrect=true;
  final user=User('','','');
  final userApi=UserApi();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _uidControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _confirmPasswordControl = TextEditingController();

  final FocusNode _uidFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();


  void _signUp(BuildContext context) async {
    if(confirmPasswordInvalidMessage!='') return ;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  )
                ],
              ),
            ),
          );
        });
    print(user);
    final response=await userApi.userRegister(user);
    print(response);

    if (context.mounted) {
      if(response.success){
        Navigator.popAndPushNamed(context,'/login');
      }
      else{
        Navigator.pop(context);
        setState(() {
          uidInvalidMessage='*invalid';
          emailInvalidMessage='*invalid';
          passwordInvalidMessage='*invalid';
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            const Text(
              "Sign up to APP",
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _uidControl,
                        cursorColor: Colors.blue[800],
                        textInputAction: TextInputAction.next,
                        focusNode: _uidFocus,
                        autofillHints: const [AutofillHints.username],
                        onEditingComplete: () {
                          _uidFocus.unfocus();
                          FocusScope.of(context).requestFocus(_emailFocus);
                          user.uid=_uidControl.text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User ID',
                        ),
                      ),
                      Text(
                          uidInvalidMessage,
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      const SizedBox(height: 3,),
                      TextFormField(
                        controller: _emailControl,
                        cursorColor: Colors.blue[800],
                        obscureText: false,
                        focusNode: _emailFocus,
                        autofillHints: const [AutofillHints.email],
                        onEditingComplete: () {
                          _emailFocus.unfocus();
                          FocusScope.of(context).requestFocus(_passwordFocus);
                          user.email=_emailControl.text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      Text(
                        uidInvalidMessage,
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      const SizedBox(height: 3,),
                      TextFormField(
                        controller: _passwordControl,
                        cursorColor: Colors.blue[800],
                        obscureText: true,
                        focusNode: _passwordFocus,
                        autofillHints: const [AutofillHints.password],
                        onEditingComplete: () {
                          _passwordFocus.unfocus();
                          FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                          user.password=_passwordControl.text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      Text(
                        passwordInvalidMessage,
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      const SizedBox(height: 3,),
                      TextFormField(
                        controller: _confirmPasswordControl,
                        cursorColor: Colors.blue[800],
                        obscureText: true,
                        focusNode: _confirmPasswordFocus,
                        onEditingComplete: () {
                          _confirmPasswordFocus.unfocus();
                          TextInput.finishAutofillContext();
                          confirmPasswordInvalidMessage=
                          (_confirmPasswordControl.text!=_passwordControl.text)?
                            '*password unmatched':'';
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                        ),
                      ),
                      Text(
                        confirmPasswordInvalidMessage,
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      const SizedBox(height: 3,),
                      SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child:TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[700],
                            ),
                            onPressed: (){
                              _signUp(context);
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  const Text(
                    "Already have one?",
                    style: TextStyle(fontSize: 18,color: Colors.white
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    child: const Text(
                      "Sign in.",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ]
            )
          ],
        )
      ),
    );
  }

}