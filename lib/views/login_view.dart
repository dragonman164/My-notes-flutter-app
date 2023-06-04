

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                  print(userCredential);
                }
                on FirebaseAuthException catch(e){
                  if(e.code == 'user-not-found'){
                    print('User not found');
                  }else if(e.code == 'wrong-password'){
                    print('Wrong Password');
                  }
                }
                catch(e){

                }

              },
              child:  const Text('Login')),
          TextButton(onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
          }, child: const Text('Not Registered yet? Register Here'))
        ],
      ),
    );

  }
}