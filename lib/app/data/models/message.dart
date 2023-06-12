import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/app/core/utils/some_functions.dart';

class Message {
  final String text;
  final DateTime date;
  final String sentBy;

  const Message({
    required this.text,
    required this.date,
    required this.sentBy,
  });

  factory Message.fromDocument(DocumentSnapshot snapshot) {
    return Message(
      text: snapshot["text"],
      date: snapshot["date"].toDate(),
      sentBy: snapshot["sentBy"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "date": SomeFunctions.fromDateTimeToJson(date),
      'sentBy': sentBy,
    };
  }
}
