import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:language_app/app/core/values/colors.dart';
import 'package:language_app/app/core/values/constants.dart';
import 'package:language_app/app/data/firebase/firestore_methods.dart';
import 'package:language_app/app/data/firebase/storage_methods.dart';
import 'package:language_app/app/modules/widgets/auth/auth_widgets.dart';
import '../controllers/personal_info_controller.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 40.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: SizedBox(
                  child: Stack(
                    children: [
                      Obx(
                        () => CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 40.r,
                            backgroundImage:
                                NetworkImage(controller.downloadUrl.value)),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              controller.uploadProfilePhoto(context);
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              size: 25.w,
                              color: Colors.grey.shade600,
                            ),
                          ))
                    ],
                  ),
                )),
                SizedBox(
                  height: 30.h,
                ),
                InfoTextField(
                  controller: controller.fullNameController,
                  textTheme: textTheme,
                  text: "Full Name",
                ),
                InfoTextField(
                  controller: controller.ageController,
                  textTheme: textTheme,
                  text: "Age",
                ),
                GestureDetector(
                  onTap: () {
                    controller.pickCountry(context);
                  },
                  child: Obx(
                    () => ChooseContainer(
                        label: "Country",
                        text: controller.country.value,
                        textTheme: textTheme),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: const Text("Gender"),
                          contentPadding: const EdgeInsets.all(50),
                          content: Row(
                            children: [
                              SizedBox(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.gender.value = 'male';
                                      },
                                      child: Image.asset(
                                        "assets/png/male2.png",
                                        height: 150.w,
                                        width: 150.w,
                                      ),
                                    ),
                                    Obx(
                                      () => Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: controller.gender.value == 'male'
                                            ? const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 50,
                                              )
                                            : const Text(""),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.gender.value = 'female';
                                      },
                                      child: Image.asset(
                                        "assets/png/test.png",
                                        height: 150.w,
                                        width: 150.w,
                                      ),
                                    ),
                                    Obx(
                                      () => Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child:
                                            controller.gender.value == 'female'
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 50,
                                                  )
                                                : const Text(""),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Obx(
                    () => ChooseContainer(
                        label: "Gender",
                        text: controller.gender.value,
                        textTheme: textTheme),
                  ),
                ),
                InkWell(
                    onTap: () {
                      controller.pickLanguage(context, true);
                    },
                    child: Obx(
                      () => ChooseContainer(
                          text: controller.selectedNativeLanguage.value.name,
                          textTheme: textTheme,
                          label: "Native Language"),
                    )),
                InkWell(
                    onTap: () {
                      controller.pickLanguage(context, false);
                    },
                    child: Obx(
                      () => ChooseContainer(
                          text: controller.selectedPracticeLanguage.value.name,
                          textTheme: textTheme,
                          label: "Practice Language"),
                    )),
                InfoTextField(
                    maxLines: 10,
                    fontSize: 20,
                    textTheme: textTheme,
                    text: "Description",
                    controller: controller.descriptionController),
                DefaultButton(
                  child: Center(
                      child: Text(
                    "NEXT",
                    style: textTheme.bodyLarge!.copyWith(
                        color: whiteColor,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold),
                  )),
                  onTap: () async {
                    String flag = await FireStoreMethods().uploadUser(
                        controller.downloadUrl.value,
                        controller.descriptionController.text,
                        controller.fullNameController.text,
                        controller.country.value,
                        controller.selectedNativeLanguage.value.name,
                        controller.selectedPracticeLanguage.value.name,
                        controller.ageController.text);
                    if (flag == 'success') {
                      Get.offAllNamed("/home");
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class ChooseContainer extends StatelessWidget {
  const ChooseContainer({
    super.key,
    required this.text,
    required this.textTheme,
    required this.label,
  });

  final String text;
  final TextTheme textTheme;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10.w,
        ),
        Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: greyColor.withOpacity(50 / 100),
              ),
              color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: textTheme.bodyLarge!.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                        color: greyColor),
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  "assets/svg/icons/down.svg",
                  color: Colors.black.withOpacity(50 / 100),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}

class InfoTextField extends StatelessWidget {
  const InfoTextField({
    super.key,
    required this.textTheme,
    required this.text,
    required this.controller,
    this.maxLines,
    this.fontSize,
  });
  final TextEditingController controller;
  final TextTheme textTheme;
  final String text;
  final int? maxLines;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10.w,
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: greyColor, fontSize: fontSize),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(color: redColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(color: greyColor.withOpacity(50 / 100))),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
