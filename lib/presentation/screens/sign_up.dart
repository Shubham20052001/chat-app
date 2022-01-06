import 'package:chat_app/logic/services/auth.dart';
import 'package:chat_app/logic/services/database.dart';
import 'package:chat_app/presentation/constants/constants.dart';
import 'package:chat_app/presentation/screens/chatrooms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  const SignUp({Key? key, required this.toggle}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signMeUp() {
    if (formKey.currentState!.validate()) {
      Map<String, String> userInfoMap = {
        'name': userNameTextEditingController.text,
        'email': emailTextEditingController.text
      };

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      )
          .then((value) {
        databaseMethods.uploadUserInfo(userInfoMap);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatRoom()),
        );
      });
    }
  }

  @override
  void dispose() {
    userNameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    emailTextEditingController.dispose();
    TapGestureRecognizer().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                            return (value!.isEmpty || value.length < 2)
                                ? 'Provide a valid user name.'
                                : null;
                          },
                          controller: userNameTextEditingController,
                          style: simpleTextStyle(),
                          decoration:
                              textFieldInputDecoration(hintText: 'Username'),
                        ),
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
                          decoration:
                              textFieldInputDecoration(hintText: 'Email'),
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
                          decoration:
                              textFieldInputDecoration(hintText: 'Password'),
                        ),
                      ],
                    ),
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
                  MaterialButton(
                    height: 50,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    color: const Color(0xff007EF4),
                    onPressed: () {
                      signMeUp();
                    },
                    child: Text(
                      'Sign Up',
                      style: simpleTextStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    color: Colors.white,
                    onPressed: () {},
                    child: Text(
                      'Sign Up with Google',
                      style: simpleTextStyle().copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: simpleTextStyle(),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign-In now',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.toggle();
                            },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
