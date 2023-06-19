import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title : const Text('Verify Email')),
      body: Column(
        children: [
          const Text('We\'ve  send you an email verification.'),

          const Text('Not recieved email? Press this button '),
          TextButton(onPressed: () async{
            final user = AuthService.firebase().sendEmailVerification();
          },child: const Text('Send email verrification')),
          TextButton(onPressed: ()  async{
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text('Restart'))
        ],
      ),
    );
  }
}
