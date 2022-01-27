import 'package:chat_app/logic/models/user_model.dart';
import 'package:chat_app/logic/services/auth.dart';
import 'package:chat_app/logic/services/database.dart';
import 'package:chat_app/logic/services/shared_preferences.dart';
import 'package:chat_app/presentation/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'chatrooms.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isLoading = false;
  QuerySnapshot<Map<String, dynamic>>? snapshotUserInfo;

  signIn() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text)
          .then((QuerySnapshot<Map<String, dynamic>> value) {
        snapshotUserInfo = value;
        SharedPreferenceFuntions.saveUserNameSharedPreferences(
          snapshotUserInfo!.docs[0].get('name'),
        );
      });

      authMethods
          .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      )
          .then((UserModel? value) {
        if (value != null) {
          SharedPreferenceFuntions.saveUserLoggedInSharedPreferences(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ChatRoom()),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    TapGestureRecognizer().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value!)
                          ? null
                          : "Enter correct email";
                    },
                    controller: emailTextEditingController,
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration(hintText: 'Email'),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      return (value!.length) < 6
                          ? 'Password should have more than 6 characters.'
                          : null;
                    },
                    controller: passwordTextEditingController,
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration(hintText: 'Password'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forget Password?',
                  style: simpleTextStyle(),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              shape: const StadiumBorder(),
              color: const Color(0xff007EF4),
              onPressed: () {
                signIn();
              },
              child: Text(
                'Sign In',
                style: simpleTextStyle(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              shape: const StadiumBorder(),
              color: Colors.white,
              onPressed: () {},
              child: Text(
                'Sign In with Google',
                style: simpleTextStyle().copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            RichText(
              text: TextSpan(
                text: "Don't have account? ",
                style: simpleTextStyle(),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Register now',
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        widget.toggle();
                      },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
