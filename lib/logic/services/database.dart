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
        .onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
