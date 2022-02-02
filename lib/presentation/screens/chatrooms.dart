import 'package:chat_app/logic/models/user_info.dart';
import 'package:chat_app/logic/services/auth.dart';
import 'package:chat_app/logic/services/database.dart';
import 'package:chat_app/logic/services/shared_preferences.dart';
import 'package:chat_app/presentation/constants/constants.dart';
import 'package:chat_app/presentation/screens/authenticate.dart';
import 'package:chat_app/presentation/screens/conversation.dart';
import 'package:chat_app/presentation/screens/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream<QuerySnapshot<Map<String, dynamic>>>? chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                    username: snapshot.data!.docs[index]
                        .get('chatroomId')
                        .toString()
                        .replaceAll('_', '')
                        .replaceAll(UserInfo.myName, ''),
                    chatRoomId: snapshot.data!.docs[index].get('chatroomId'),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    UserInfo.myName =
        (await SharedPreferenceFuntions.getUserNameSharedPreferences()) ?? '';
    chatRoomsStream = databaseMethods.getChatRooms(UserInfo.myName);
    setState(() {});
  }

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
      body: chatRoomList(),
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

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatRoomId;
  const ChatRoomTile({
    Key? key,
    required this.username,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: CircleAvatar(
        child: Text(username.substring(0, 1)),
      ),
      title: Text(
        username,
        style: simpleTextStyle(),
      ),
      tileColor: Colors.black26,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Conversation(chatRoomId: chatRoomId),
          ),
        );
      },
    );
  }
}
