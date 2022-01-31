import 'package:chat_app/logic/models/user_info.dart';
import 'package:chat_app/logic/services/database.dart';
import 'package:chat_app/presentation/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  final String chatRoomId;
  const Conversation({Key? key, required this.chatRoomId}) : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatMessageStream;

  Widget ChatMessageList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatMessageStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data!.docs[index].get('message'),
                    isSendByMe: snapshot.data!.docs[index].get('sendBy') ==
                        UserInfo.myName,
                  );
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sendBy': UserInfo.myName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.clear();
    }
  }

  @override
  void initState() {
    setState(() {
      chatMessageStream =
          databaseMethods.getConversationMessages(widget.chatRoomId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Stack(
        children: [
          ChatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color(0x54FFFFFF),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
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
                      child: Image.asset('assets/images/send.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile({Key? key, required this.message, required this.isSendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
        right: isSendByMe ? 20 : 0,
        left: isSendByMe ? 0 : 20,
      ),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe
                ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
          ),
          borderRadius: isSendByMe
              ? const BorderRadius.only(
                  topRight: Radius.circular(23),
                  topLeft: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(23),
                  topLeft: Radius.circular(23),
                  bottomRight: Radius.circular(23),
                ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
