import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:language_app/app/core/values/colors.dart';
import 'package:language_app/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            supportedLocales: const [
              Locale('en'),
              Locale('el'),
              Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
              Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
            ],
            localizationsDelegates: const [
              CountryLocalizations.delegate,
            ],
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                displayLarge: GoogleFonts.openSans(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: blackTextColor),
                displayMedium: GoogleFonts.openSans(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: blackTextColor),
                bodyLarge: GoogleFonts.openSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: blackTextColor),
                bodyMedium: GoogleFonts.openSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: blackTextColor),
                bodySmall: GoogleFonts.openSansCondensed(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  letterSpacing: 1,
                ),
              ),
            ),
          );
        }),
  );
}
