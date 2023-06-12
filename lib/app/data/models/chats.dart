import 'package:cloud_firestore/cloud_firestore.dart';

class Chats {
  String userId;
  Chats({
    required this.userId,
  });

  factory Chats.fromDocument(DocumentSnapshot snapshot) {
    return Chats(userId: snapshot["userId"]);
  }

  Map<String, String> toJson() {
    return {
      'userId': userId,
    };
  }
}
