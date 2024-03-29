import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Login'),),
      body: Column(
        children: [
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Enter your Email Here'
            ),
            controller: _email,
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
                hintText: 'Enter Your Password Here'
            ),
            controller: _password,
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try{
                  await AuthService.firebase().logIn(email: email, password: password);

                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false){
                    Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                  }else{
                    Navigator.of(context).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);

                  }
                }
                on UserNotFoundAuthException{
                  await showErrorDialog(context, 'User not found');
                }
                on WrongPasswordAuthException{
                  await showErrorDialog(context,'Wrong Password');
                }
                on GenericAuthException{
                  await showErrorDialog(context, 'Authentication Error');
                }
              },
              child:  const Text('Login')),
          TextButton(onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text('Not Registered yet? Register Here'))
        ],
      ),
    );

  }
}

