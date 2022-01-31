import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUsername(
    String username,
  ) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: username)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUserEmail(
    String userEmail,
  ) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(Map<String, dynamic> userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  createChatRoom(String chatRoomId, Map<String, dynamic> chatRoomMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, Map<String, dynamic> messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversationMessages(
    String chatRoomId,
  ) {
    return FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }
}
