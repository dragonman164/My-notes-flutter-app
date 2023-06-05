import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
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
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }on FirebaseAuthException catch(e){
                  if(e.code == 'weak-password'){
                    await showErrorDialog(context, 'weak-password');
                  }else if(e.code == 'email-already-in-use'){
                    await showErrorDialog(context, 'email-already-in-use');
                  }
                  else if(e.code == 'invalid-email'){
                    await showErrorDialog(context, 'invalid-email');
                  }else{
                    await showErrorDialog(context, 'Error ${e.code}');
                  }
                }
                catch(e){
                  await showErrorDialog(context, e.toString());
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