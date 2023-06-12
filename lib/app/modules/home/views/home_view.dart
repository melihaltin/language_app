//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:language_app/app/core/values/colors.dart';
import 'package:language_app/app/core/values/constants.dart';
import 'package:language_app/app/data/firebase/firestore_methods.dart';
import 'package:language_app/app/data/providers/user_provider.dart';
import 'package:language_app/app/modules/home/controllers/home_widget_controller.dart';

import '../../../data/models/user.dart' as model;
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model.User? user = UserProvider().getUser;
    final textTheme = Theme.of(context).textTheme;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return user == null
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: whiteColor,
            ),
          )
        : Scaffold(
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.mail), label: ""),
                ],
                backgroundColor: Colors.amber,
                elevation: 2,
                
              ),
            ),
            appBar: AppBar(
              backgroundColor: whiteColor,
              elevation: 0,
              leadingWidth: 0,
              title: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),
                    radius: 20.r,
                  ),
                  Center(
                    child: Text("Explore", style: textTheme.displayMedium!),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Stack(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.data == null) {
                          print("aaaaa");
                        }

                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (ctx, index) {
                              controller.userId =
                                  snapshot.data!.docs[index].data()["userId"];

                              controller.date = snapshot.data!.docs[index]
                                  .data()['date']
                                  .toDate();
                              //  await controller.addData();
                              //   // const AsyncSnapshot.waiting();
                              return FutureBuilder(
                                initialData: false,
                                future: controller
                                    .addData(), //tamamlanmıyor tamamlanmasını beklememiz gerkeiyor aslında

                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    print(index);
                                    if (controller.user!.practiceLanguage !=
                                        user.practiceLanguage) {
                                      return const SizedBox();
                                    }
                                    return Column(
                                      children: [
                                        HomeWidget(
                                          textTheme: textTheme,
                                          date: controller.date!,
                                          user: controller.user,
                                        ),
                                      ],
                                    );
                                  }
                                },
                              );
                            });
                      }),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: FloatingActionButton(onPressed: () {
                      var a = FireStoreMethods().uploadPost(DateTime.now());

                      print(a);
                    }),
                  )
                ],
              ),
            ),
          );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget(
      {super.key,
      required this.textTheme,
      required this.user,
      required this.date});

  // final String userId;
  final TextTheme textTheme;
  final DateTime date;
  final model.User? user;
  @override
  Widget build(BuildContext context) {
    // userId = userId;
    // late String photoUrl;
    // late String country;
    // late String fullName;
    // late String nativeLanguage;
    // late String practiceLanguage;

    // Future<void> addData() async {
    //   user = await  FireStoreMethods().getUserDetails(userId);
    // }

    if (user == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        elevation: 15,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 16.h, left: 14.w, right: 1),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoUrl),
                    radius: 40.r,
                  ),
                  SizedBox(
                    width: 22.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            user!.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.openSans(
                              color: const Color(0xff151522),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          user!.country,
                          style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: blackTextColor.withOpacity(80 / 100),
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 21.h,
                        ),
                        Text("Native Languge: ${user!.nativeLanguage}",
                            style: textTheme.bodySmall),
                        Text("Practice Languge: ${user!.practiceLanguage} ",
                            style: textTheme.bodySmall),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "5m ago",
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: blackTextColor.withOpacity(50 / 100),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/message");
                          },
                          child: SvgPicture.asset(
                            "assets/svg/icons/message.svg",
                            height: 27.h,
                            width: 27.w,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
