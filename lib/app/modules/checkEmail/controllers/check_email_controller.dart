import 'dart:async';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
//import 'package:language_app/app/modules/SendEmail/views/send_email_view.dart';

class CheckEmailController extends GetxController {
  Timer? timer;

  @override
  void onReady() {
    super.onReady();
    test();
  }

  test() {
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        FirebaseAuth.instance.currentUser!.reload();
      },
    );
  }

  void openGMail() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.google.android.gm',
      openStore: true,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    timer!.cancel();
  }
}
