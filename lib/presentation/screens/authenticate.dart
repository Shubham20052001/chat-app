import 'package:chat_app/presentation/screens/sign_in.dart';
import 'package:chat_app/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleScreen() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
        toggle: toggleScreen,
      );
    } else {
      return SignUp(
        toggle: toggleScreen,
      );
    }
  }
}
