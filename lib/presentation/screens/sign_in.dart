import 'package:chat_app/presentation/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            TextField(
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration(hintText: 'Email'),
            ),
            TextField(
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration(hintText: 'Password'),
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
              onPressed: () {},
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
                        widget.toggle;
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
