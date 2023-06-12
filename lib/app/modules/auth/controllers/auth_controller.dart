import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLogin = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEmailVerified = false;

  void signup(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: pwController.text.trim());
      await auth.signOut();
      await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: pwController.text.trim());
      Get.offAllNamed("/send-email", arguments: "verify");
    } catch (e) {
      Get.snackbar("About User", e.toString());
    }
  }

  void signin(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: pwController.text.trim());
      isEmailVerified = auth.currentUser!.emailVerified;
      if (isEmailVerified) {
        Get.toNamed("/home");
      } else {
        Get.toNamed("/send-email", arguments: "verify");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("About User", e.message!);
    }
  }

  void logOut() async {
    await auth.signOut();
  }

  // @override
  // void onInit() {
  //   super.onInit();

  // }

  void authMethod(BuildContext context) {
    if (isLogin.isTrue) {
      signin(context);
    } else {
      signup(context);
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    pwController.clear();
  }
}
