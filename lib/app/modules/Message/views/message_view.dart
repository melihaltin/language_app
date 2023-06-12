import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:language_app/app/core/values/colors.dart';
import 'package:language_app/app/data/firebase/firestore_methods.dart';
import 'package:language_app/app/data/models/message.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    final textTheme = Theme.of(context).textTheme;

    controller.messaging.value =
        MediaQuery.of(context).viewInsets.bottom == 0 &&
                controller.messageController.text == ""
            ? false
            : true;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversation',
          style:
              textTheme.bodyLarge!.copyWith(color: whiteColor, fontSize: 17.sp),
        ),
        centerTitle: true,
        backgroundColor: blueColor,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.chevron_left)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(senderId)
            .collection("user")
            .doc("chats")
            .collection(senderId) //receiver ID
            .snapshots(),
        builder: (context, snapshot) {
          List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshotList =
              snapshot.data != null ? snapshot.data!.docs : [];
          List<Message> messages =
              snapshotList.map((doc) => Message.fromDocument(doc)).toList();
          int lengthOfMessages = messages.length - 1;

          return Column(
            children: [
              Expanded(
                child: GroupedListView(
                  reverse: true,
                  floatingHeader: true,
                  order: GroupedListOrder.DESC,
                  shrinkWrap: true,
                  elements: messages,
                  groupBy: (message) => DateTime(
                    message.date.year,
                    message.date.month,
                    message.date.day,
                  ),
                  groupHeaderBuilder: (message) => SizedBox(
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 125.w),
                      child: Card(
                        color: const Color(0xfff2f2f2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99.r)),
                        child: Center(
                          child: Text(
                            DateFormat.yMMMd().format(message.date),
                            style: textTheme.bodyMedium!
                                .copyWith(color: greyColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  indexedItemBuilder: (context, message, int index) {
                    bool isSentByMe = message.sentBy == senderId;
                    bool isLastMessageSentByMe = upMessageControl(
                        isSentByMe: isSentByMe,
                        lastMessage: lengthOfMessages - index == 0
                            ? null
                            : messages[lengthOfMessages - index - 1].sentBy ==
                                senderId);
                    return Align(
                      alignment: isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        constraints: BoxConstraints(maxWidth: 320.w),
                        child: Column(
                          crossAxisAlignment: isSentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            isLastMessageSentByMe
                                ? const CircleAvatar(
                                    backgroundColor: Colors.amber)
                                : const SizedBox(),
                            Padding(
                              padding: isSentByMe
                                  ? EdgeInsets.only(right: 25.w)
                                  : EdgeInsets.only(left: 25.w),
                              child: Card(
                                elevation: 8,
                                color: isSentByMe ? blueColor : whiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: isSentByMe
                                      ? const Radius.circular(20)
                                      : const Radius.circular(2),
                                  bottomLeft: const Radius.circular(20),
                                  bottomRight: const Radius.circular(20),
                                  topRight: isSentByMe
                                      ? const Radius.circular(2)
                                      : const Radius.circular(20),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    message.text + index.toString(),
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: isSentByMe ? whiteColor : null),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 90.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: const BoxDecoration(
                  color: Color(0xffE4E4E4),
                ),
                child: Row(
                  children: [
                    Obx(
                      () => Visibility(
                        visible: !controller.messaging.value,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/icons/camera.svg",
                              height: 35.h,
                              width: 35.h,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: !controller.messaging.value,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/icons/pictures.svg",
                              height: 35.h,
                              width: 35.h,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99.r),
                            color: whiteColor),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                minLines: 1,
                                maxLines: 3,
                                controller: controller.messageController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: "Message...",
                                  hintStyle: TextStyle(color: greyColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Obx(
                              () {
                                return SizedBox(
                                  child: GestureDetector(
                                    onTap: () async {
                                      String a = await FireStoreMethods()
                                          .uploadMessage(
                                              userId: senderId,
                                              date: DateTime.now(),
                                              text: controller
                                                  .messageController.text);
                                      if (a != 'success') {
                                        Get.snackbar("Error", a);
                                      }

                                      controller.messageController.text = "";
                                    },
                                    child: controller.messaging.isTrue
                                        ? SvgPicture.asset(
                                            "assets/svg/icons/send.svg",
                                            height: 28,
                                            width: 28,
                                          )
                                        : GestureDetector(
                                            onTap: () async {},
                                            child: SvgPicture.asset(
                                              "assets/svg/icons/message.svg",
                                              height: 28,
                                              width: 28,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool upMessageControl(
      {required bool isSentByMe, required bool? lastMessage}) {
    if (lastMessage == null) {
      return true;
    } else {
      if (isSentByMe && lastMessage) {
        return false;
      } else if (!isSentByMe && !lastMessage) {
        return false;
      } else {
        return true;
      }
    }
  }
}
