import 'package:get/get.dart';

extension PercentedScreen on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.height * (this / 100));
}

extension ResponsiveText on double {
  double get sp => (Get.width / 100 * (this / 3));
}
