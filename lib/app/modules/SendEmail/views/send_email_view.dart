import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/constants.dart';

import '../../widgets/auth/auth_widgets.dart';
import '../controllers/send_email_controller.dart';

class SendEmailView extends GetView<SendEmailController> {
  const SendEmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SendEmailController controller = SendEmailController();
    final String argument = Get.arguments as String;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        elevation: 0,
        backgroundColor: blueColor,
        title: Text(
          'Back',
          style: textTheme.displayMedium!
              .copyWith(color: whiteColor, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            argument == 'verify'
                ? Text(
                    "Verify Email",
                    style: textTheme.displayLarge!
                        .copyWith(color: blackTextColor, fontSize: 23.sp),
                  )
                : Text(
                    "Reset Password",
                    style: textTheme.displayLarge!
                        .copyWith(color: blackTextColor, fontSize: 23.sp),
                  ),
            SizedBox(
              height: 10.h,
            ),
            argument == 'verify'
                ? Text(
                    "Enter the email associated with your account and we'll send an email with instructions to verify your email.",
                    style: textTheme.bodyLarge!.copyWith(color: greyColor),
                  )
                : Text(
                    "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
                    style: textTheme.bodyLarge!.copyWith(color: greyColor),
                  ),
            argument != 'verify'
                ? Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      AuthTextField(
                        isPw: false,
                        textEditingController: controller.emailController,
                      ),
                      Text(
                        "Email Adresses",
                        style: textTheme.bodyMedium!.copyWith(
                            color: greyColor, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  )
                : const SizedBox(height: 30),
            SizedBox(
              height: 20.h,
            ),
            DefaultButton(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.mail_outlined, color: whiteColor),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Center(
                      child: argument == 'verify'
                          ? Text(
                              "Verify Email",
                              style: textTheme.bodyLarge!.copyWith(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500),
                            )
                          : Text(
                              "Reset Password",
                              style: textTheme.bodyLarge!.copyWith(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500),
                            ))
                ],
              ),
              onTap: () async {
                if (argument == "verify") {
                  await controller.sendVerificationEmail();
                  Get.offAllNamed("/check-email", arguments: argument);
                } else {
                  await controller.resetPassword();
                  Get.offAllNamed("/check-email", arguments: argument);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
