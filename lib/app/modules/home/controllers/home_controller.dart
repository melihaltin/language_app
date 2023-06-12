import 'package:get/get.dart';
import 'package:language_app/app/data/firebase/firestore_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/user.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  void setTime() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('startTime', DateTime.now().toString());
  }

  String userId = "";
  User? user;
  DateTime? date;

  Future<bool> addData() async {
    try {
      print("FIRSTTTT");
      user = await FireStoreMethods().getUserDetails(userId);
      print("testt");
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
