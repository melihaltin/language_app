import 'package:get/get.dart';
import 'package:language_app/app/data/firebase/firestore_methods.dart';

import '../../../data/models/user.dart';
import '../../../data/providers/user_provider.dart';

class HomeWidgetController extends GetxController {
  String userId = "";
  User? user;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await addData();
  }

  addData() async {
    user = await FireStoreMethods().getUserDetails(userId);
  }

  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   super.onReady();
  //   addData();
  // }
}
