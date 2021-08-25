import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deify/app/controllers/auth_controller.dart';
import 'package:deify/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  final authc = Get.find<AuthController>();
  List dataTemp = List.generate(10, (i) => null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Stack(
        children: [
          svg,
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: context.mediaQueryPadding.top,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.03,
                  vertical: Get.height * 0.03,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.white70, width: Get.width * 0.005),
                  ),
                ),
                // color: Colors.deepOrange.shade500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: Get.width * 0.12,
                        color: Colors.white,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.PROFILE),
                        splashColor: Colors.deepOrange,
                        child: Icon(
                          Icons.person,
                          size: Get.width * 0.12,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.chatsStream(authc.user.value.email!),
                  builder: (context, snapshot1) {
                    if (snapshot1.connectionState == ConnectionState.active) {
                      var allChats = (snapshot1.data!.data()
                          as Map<String, dynamic>)["chats"] as List;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: allChats.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller
                                .friendStream(allChats[index]["connection"]),
                            builder: (context, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.active) {
                                var data = snapshot2.data!.data();
                                return ListTile(
                                  onTap: allChats[index]["total_unread"] == 0
                                  ? (){}
                                      :()=>Get.toNamed(Routes.CHAT_ROOM),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      Get.width * 0.1,
                                    ),
                                    child: data!["photoUrl"] == "noimage"
                                        ? Image.asset(
                                            "assets/logo/noimage.png",
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            data["photoUrl"],
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  title: Text(
                                    data["name"],
                                    style: TextStyle(
                                      fontSize: Get.width * 0.050,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: data["status"]==""
                                  ? SizedBox()
                                  :Text(
                                    data["status"],
                                    style: TextStyle(
                                      fontSize: Get.width * 0.035,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: allChats[index]["total_unread"] == 0
                                      ? SizedBox()
                                      : Chip(
                                          backgroundColor:
                                              Colors.deepOrange.shade500,
                                          label: Text(
                                            "${allChats[index]["total_unread"]}",
                                            style: TextStyle(
                                              fontSize: Get.width * 0.030,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                );
                              }
                              ;
                              return LinearProgressIndicator();
                            },
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCH),
        backgroundColor: Colors.white,
        splashColor: Colors.deepOrange,
        child: Icon(
          Icons.search,
          color: Colors.deepOrange,
          size: Get.width * 0.09,
        ),
      ),
    );
  }
}
