import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:language_app/app/data/providers/user_provider.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  late Rx<User?> _user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  // RxBool isEmailVerified = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        _user = Rx<User?>(auth.currentUser);
        _user.bindStream(auth.userChanges());
        ever(_user, _inititalScreen);
      },
    );
  }

  Future<bool> checkExist() async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('user')
          .doc('userInfos')
          .get()
          .then(
        (value) {
          exist = value.exists;
        },
      );
    } catch (e) {
      exist = false;
    }

    return exist;
  }

  static bool helper = false;

  _inititalScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed("/auth");
    } else if (user.emailVerified) {
      bool exist = await checkExist();

      if (exist) {
        await addData();
        Get.offAllNamed("/home");
      } else {
        Get.offAllNamed("/personal-info");
      }
    } else if (!helper) {
      helper = true;
      Get.offAllNamed("/send-email", arguments: "verify");
    }
  }

  addData() async {
    UserProvider _userProvider = UserProvider();
    await _userProvider.refreshUser();
  }
}
