import 'package:agriapp/screens/auth/sign_in.dart';
import 'package:agriapp/services/auth/signin_mannager.dart';
import 'package:flutter/material.dart';

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SigninManager().signOut();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return SignIn();
          }));
        },
      ),
    );
  }
}
