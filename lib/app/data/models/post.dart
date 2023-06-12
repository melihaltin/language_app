import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/utils/some_functions.dart';

class Post {
  final String userId;
  final DateTime date;

  Post(this.userId, this.date);
  factory Post.fromSnap(DocumentSnapshot snapshot) {
    return Post(snapshot["userId"], snapshot["date"].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      "date": SomeFunctions.fromDateTimeToJson(date),
    };
  }
}
