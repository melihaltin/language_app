import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/auth/auth_widgets.dart';
import '../controllers/auth_controller.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:language_app/app/core/values/colors.dart';
import 'package:language_app/app/core/values/constants.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        leadingWidth: 0,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.close,
                color: Color(0xff151522),
              ),
              GestureDetector(
                onTap: () {
                  controller.isLogin.toggle();
                },
                child: Obx(() {
                  return controller.isLogin.isTrue
                      ? Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: blueColor),
                        )
                      : Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: blueColor),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Get Started",
                style: textTheme.displayLarge,
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 95),
                child: Text(
                  "Login or register to see people who want to learn the language you want to learn..",
                  style: textTheme.bodyMedium!
                      .copyWith(color: greyColor, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              AuthTextField(
                isPw: false,
                textEditingController: controller.emailController,
              ),
              SizedBox(
                height: 20.h,
              ),
              AuthTextField(
                textEditingController: controller.pwController,
                isPw: true,
              ),
              SizedBox(
                height: heightPadding,
              ),
              DefaultButton(
                onTap: () {
                  controller.authMethod(context);
                },
                child: Center(
                  child: Obx(
                    () => controller.isLogin.isTrue
                        ? Text(
                            "Login",
                            style: textTheme.bodyLarge!
                                .copyWith(color: whiteColor),
                          )
                        : Text(
                            "SignUp",
                            style: textTheme.bodyLarge!
                                .copyWith(color: whiteColor),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: heightPadding,
              ),
              Obx(
                () => controller.isLogin.isTrue
                    ? Center(
                        child: GestureDetector(
                        onTap: () {
                          Get.toNamed("/forgot-pw", arguments: 'forgot');
                        },
                        child: Text(
                          "Forget Password?",
                          style:
                              textTheme.bodyLarge!.copyWith(color: blueColor),
                        ),
                      ))
                    : const SizedBox(),
              ),
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: Text(
                  "OR",
                  style: textTheme.bodyLarge!.copyWith(color: greyColor),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              DefaultButton(
                onTap: () {},
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10).w,
                          child:
                              SvgPicture.asset("assets/svg/icons/google.svg"),
                        ),
                        const VerticalDivider(
                          color: whiteColor,
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "Continue with Google",
                        style: textTheme.bodyLarge!.copyWith(color: whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
