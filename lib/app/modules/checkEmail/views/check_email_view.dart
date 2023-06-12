import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:language_app/app/core/values/colors.dart';
import 'package:language_app/app/core/values/constants.dart';

import '../controllers/check_email_controller.dart';

class CheckEmailView extends GetView<CheckEmailController> {
  const CheckEmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final CheckEmailController controller = Get.find();
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/pictures/email.svg"),
                SizedBox(
                  height: heightPadding,
                ),
                Text(
                  "Check your mail",
                  style: textTheme.displayLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "We have sent a password recover",
                  style: textTheme.bodyLarge!
                      .copyWith(color: greyColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  "instructions to your email.",
                  style: textTheme.bodyLarge!
                      .copyWith(color: greyColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: heightPadding,
                ),
                GestureDetector(
                  onTap: controller.openGMail,
                  child: Container(
                    height: 50.h,
                    width: 175.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: blueColor),
                    child: Center(
                      child: Text(
                        "Open Gmail",
                        style: textTheme.bodyLarge!.copyWith(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            left: 40.w,
            child: Column(
              children: [
                Text(
                  "Did not receive the email?. Check your spam filter,",
                  style: textTheme.bodyMedium!
                      .copyWith(color: greyColor, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "or",
                      style: textTheme.bodyMedium!.copyWith(
                          color: greyColor, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text(
                        " try another email adress",
                        style: textTheme.bodyMedium!.copyWith(
                            color: blueColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
