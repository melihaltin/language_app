import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:language_app/app/core/utils/some_functions.dart';
import 'package:language_app/app/data/models/message.dart';
import 'package:language_app/app/data/models/post.dart';
import 'package:language_app/app/data/models/user.dart' as model;

class FireStoreMethods extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//----------------------------------------------------------
  Future<model.User> getUserDetails(String userId) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection("user")
        .doc("userInfos")
        .get();
    return model.User.fromDocument(documentSnapshot);
  }

//---------------------------------------------------------------
  Future<String> uploadUser(
    String profileImage,
    String description,
    String fullName,
    String country,
    String nativeLanguage,
    String practiceLanguage,
    String age,
  ) async {
    String result = "";
    try {
      model.User user = model.User(
        fullName: fullName,
        country: country,
        nativeLanguage: nativeLanguage,
        practiceLanguage: practiceLanguage,
        description: description,
        age: age,
        photoUrl: profileImage,
      );

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection("user")
          .doc("userInfos")
          .set(user.toJson());

      result = "success";
      return result;
    } catch (err) {
      result = err.toString();
      return result;
    }
  }

  //----------------------------------------------------------------------------
  Future<String> uploadPost(
    DateTime date,
  ) async {
    String result = "";
    try {
      Post _post = Post(_auth.currentUser!.uid, date);
      await _firestore
          .collection('posts')
          .doc(_auth.currentUser!.uid)
          .set(_post.toJson());

      result = "success";
    } catch (err) {
      result = "error";
    }
    return result;
  }

  //----------------------------------------------------------------------------
  Future<String> uploadMessage({
    required String text,
    required DateTime date,
    required String userId,
  }) async {
    String result = "";
    try {
      Message message =
          Message(text: text, date: date, sentBy: _auth.currentUser!.uid);

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection("user")
          .doc("chats")
          .collection(userId)
          .doc(SomeFunctions.fromDateTimeToJson(date).toString())
          .set(message.toJson());
      result = "success";
      return result;
    } catch (err) {
      result = err.toString();
      return result;
    }
  }
}
