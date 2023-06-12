import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final RxBool messaging = false.obs;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
}
