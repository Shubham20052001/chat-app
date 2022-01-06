import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUserInfo(Map<String, dynamic> userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }
}
