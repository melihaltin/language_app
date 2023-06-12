import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import '../../../core/values/colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    this.textEditingController,
    required this.isPw,
  });
  final TextEditingController? textEditingController;
  final bool isPw;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != null) {
          print(value);
          bool test = GetUtils.isEmail(value);
          if (isPw == false) {
            return (!test ? 'Enter a valid email' : null);
          } else {
            return (value.length > 6 ? null : 'Enter minimum 6 characters');
          }
        }
      },
      controller: textEditingController,
      obscureText: isPw ? true : false,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5).w,
            borderSide: const BorderSide(color: redColor),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: greyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5)).r)),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.child, required this.onTap});

  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5).r, color: blueColor),
        child: child,
      ),
    );
  }
}
