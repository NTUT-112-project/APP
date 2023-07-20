import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState()=>_RegisterPage();
}
class _RegisterPage extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _uidControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();

  final FocusNode _uidFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
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
              "Sign up",
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
                        controller: _uidControl,
                        cursorColor: Colors.blue[800],
                        textInputAction: TextInputAction.next,
                        focusNode: _uidFocus,
                        autofillHints: const [AutofillHints.username],
                        onEditingComplete: () {
                          _uidFocus.unfocus();
                          FocusScope.of(context).requestFocus(_emailFocus);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User ID',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailControl,
                        cursorColor: Colors.blue[800],
                        obscureText: true,
                        focusNode: _emailFocus,
                        autofillHints: const [AutofillHints.email],
                        onEditingComplete: () {
                          _emailFocus.unfocus();
                          FocusScope.of(context).requestFocus(_passwordFocus);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
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
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                //sign up request
              },
              child: const Text(
                "Sign up",
                style: TextStyle(fontSize: 20,color: Colors.blue),
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