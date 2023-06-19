import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/showErrorDialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {


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
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),),
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
                  await AuthService.firebase().createUser(email: email, password: password);
                  final user = AuthService.firebase().currentUser;
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
                on WeakPasswordAuthException{
                  await showErrorDialog(context, 'weak-password');
                }
                on EmailAlreadyInUseAuthException{
                  await showErrorDialog(context, 'email-already-in-use');
                }
                on InvalidEmailAuthException{
                  await showErrorDialog(context, 'invalid-email');
                }
                on GenericAuthException{
                  await showErrorDialog(context, 'Failed to Register');
                }
              },
              child:  const Text('Register')),
          TextButton(onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
          }, child: const Text('Already Registered? Login Here'))
        ],
      ),
    );
  }
}