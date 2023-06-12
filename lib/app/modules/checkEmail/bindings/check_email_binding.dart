import 'package:get/get.dart';
import 'package:language_app/app/modules/splash/controllers/splash_controller.dart';

import '../controllers/check_email_controller.dart';

class CheckEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckEmailController>(
      () => CheckEmailController(),
    );
  }
}
