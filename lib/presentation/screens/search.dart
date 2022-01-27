import 'package:chat_app/logic/models/user_info.dart';
import 'package:chat_app/logic/services/database.dart';
import 'package:chat_app/presentation/constants/constants.dart';
import 'package:chat_app/presentation/screens/conversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  QuerySnapshot<Map<String, dynamic>>? searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  // Create chatroom and send user to conversation screen
  createChatroomAndStartConversation({
    required String username,
  }) {
    if (username != UserInfo.myName) {
      List<String> users = [username, UserInfo.myName];
      String chatRoomId = getChatroomId(username, UserInfo.myName);
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatroomId': chatRoomId,
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Conversation()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot talk to yourself')),
      );
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return searchTile(
                username: searchSnapshot!.docs[index].get('name'),
                userEmail: searchSnapshot!.docs[index].get('email'),
              );
            },
          )
        : Container();
  }

  Widget searchTile({
    required String username,
    required String userEmail,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: simpleTextStyle(),
              ),
              Text(
                userEmail,
                style: simpleTextStyle(),
              )
            ],
          ),
          const Spacer(),
          MaterialButton(
            height: 40,
            shape: const StadiumBorder(),
            color: const Color(0xff007EF4),
            onPressed: () {
              createChatroomAndStartConversation(username: username);
            },
            child: Text(
              'Message',
              style: simpleTextStyle(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Container(
            color: const Color(0x54FFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'search username...',
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0x36FFFFFF),
                          Color(0x0FFFFFFF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset('assets/images/search_white.png'),
                  ),
                ),
              ],
            ),
          ),
          searchList(),
        ],
      ),
    );
  }
}

getChatroomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}
