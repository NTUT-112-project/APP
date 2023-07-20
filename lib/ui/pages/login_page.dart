import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState()=>_LoginPage();
}
class _LoginPage extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _accountControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();

  final FocusNode _accountFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign in",
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'password',
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  //sign in
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 20,color: Colors.blue),
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