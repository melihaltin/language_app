import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:get/get.dart';
import 'package:language_app/app/data/firebase/firestore_methods.dart';
import 'package:language_app/app/data/models/user.dart';

class UserProvider extends GetxController {
  static final Rx<User> _user = User(
          fullName: "",
          photoUrl: "",
          nativeLanguage: "",
          practiceLanguage: "",
          country: "",
          age: "",
          description: "")
      .obs;
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();
  final String uid = firebase.FirebaseAuth.instance.currentUser!.uid;
  User? get getUser => _user.value;

  Future<void> refreshUser() async {
    User user = await _fireStoreMethods.getUserDetails(uid);
    _user.value = user;
  }
}
