import 'package:chat_app/logic/services/auth.dart';
import 'package:chat_app/presentation/screens/authenticate.dart';
import 'package:chat_app/presentation/screens/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat App'),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              authMethods.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Authenticate()),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
