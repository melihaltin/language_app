import 'package:get/get.dart';

import '../modules/Message/bindings/message_binding.dart';
import '../modules/Message/views/message_view.dart';
import '../modules/PersonalInfo/bindings/personal_info_binding.dart';
import '../modules/PersonalInfo/views/personal_info_view.dart';
import '../modules/SendEmail/bindings/send_email_binding.dart';
import '../modules/SendEmail/views/send_email_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/checkEmail/bindings/check_email_binding.dart';
import '../modules/checkEmail/views/check_email_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SEND_EMAIL,
      page: () => const SendEmailView(),
      binding: SendEmailBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_EMAIL,
      page: () => const CheckEmailView(),
      binding: CheckEmailBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
  ];
}
