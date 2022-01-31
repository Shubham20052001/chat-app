import 'package:chat_app/logic/services/shared_preferences.dart';
import 'package:chat_app/presentation/screens/authenticate.dart';
import 'package:chat_app/presentation/screens/chatrooms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isUserLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await SharedPreferenceFuntions.getUserLoggedInSharedPreferences()
        .then((value) {
      setState(() {
        isUserLoggedIn = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff145C9E),
        ),
        primaryColor: const Color(0xff145C9E),
        scaffoldBackgroundColor: const Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
      ),
      home: isUserLoggedIn ? const ChatRoom() : const Authenticate(),
    );
  }
}
