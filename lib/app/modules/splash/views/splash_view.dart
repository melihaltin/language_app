import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashView'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text(
            'SplashView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
