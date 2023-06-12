import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future resetPassword() async {
    try {
      final user = FirebaseAuth.instance;
      await user.sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
