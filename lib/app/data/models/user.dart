import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String fullName;
  final String photoUrl;
  final String nativeLanguage;
  final String practiceLanguage;
  final String country;
  final String age;
  final String description;

  User(
      {required this.photoUrl,
      required this.fullName,
      required this.nativeLanguage,
      required this.practiceLanguage,
      required this.country,
      required this.age,
      required this.description});

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
        fullName: document["fullName"],
        photoUrl: document["photoUrl"],
        nativeLanguage: document["nativeLanguage"],
        practiceLanguage: document["practiceLanguage"],
        country: document["country"],
        age: document["age"],
        description: document["description"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "photoUrl": photoUrl,
      "nativeLanguage": nativeLanguage,
      "practiceLanguage": practiceLanguage,
      "country": country,
      "age": age,
      "description": description,
    };
  }
}
