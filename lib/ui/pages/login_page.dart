import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/user/user.dart';
import '../../api/user/user_api.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState()=>_LoginPage();
}
class _LoginPage extends State<LoginPage>{
  bool isWrongAccountOrPassword=false;
  final user=User('','','');
  final userApi=UserApi();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _accountControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();

  final FocusNode _accountFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _signIn(BuildContext context) async {
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
    final response=await userApi.login(user);
    print(response);

    if (context.mounted) {
      if(response.success){
        Navigator.popAndPushNamed(context,'/home');
      }
      else{
        Navigator.pop(context);
        setState(() {
          isWrongAccountOrPassword=true;
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
                'APP',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Sign in to APP",
                style: TextStyle(fontSize: 20,color: Colors.white),
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
                          onEditingComplete: () {
                            _accountFocus.unfocus();
                            FocusScope.of(context).requestFocus(_passwordFocus);
                            setState(() {
                              user.email=_accountControl.text;//identify account is email or user ID
                            });
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
                          onEditingComplete: () {
                            _passwordFocus.unfocus();
                            TextInput.finishAutofillContext();
                            setState(() {
                              user.password=_passwordControl.text;//identify account is email or user ID
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'password',
                          ),
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child:TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[700],
                            ),
                            onPressed: (){
                              _signIn(context);
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ),
                        const SizedBox(height: 5),
                        Text(
                          (isWrongAccountOrPassword)?"*Wrong account or password":"",
                          style: const TextStyle(fontSize: 15,color: Colors.red),
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
                      "No account?",
                      style: TextStyle(fontSize: 18,color: Colors.white
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.popAndPushNamed(context, '/register');
                      },
                      child: const Text(
                        "Create one.",
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