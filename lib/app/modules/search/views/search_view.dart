import 'package:deify/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          Get.height * 0.14,
        ),
        child: AppBar(
          backgroundColor: Colors.deepOrange.shade500,
          title: Text('Search'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.015, horizontal: Get.width * 0.03),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  controller.searchFriend(
                    value,
                    authC.user.value.email!,
                  );
                },
                onEditingComplete: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    currentFocus.focusedChild!.unfocus();
                  }
                },
                controller: controller.searchC,
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Get.width * 0.1,
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: Get.width * 0.1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Get.width * 0.1,
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: Get.width * 0.1,
                    ),
                  ),
                  hintText: "Search new friends here..",
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05, vertical: Get.width * 0.01),
                  suffixIcon: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(
                      Get.width * 0.1,
                    ),
                    splashColor: Colors.deepOrange,
                    child: Icon(
                      Icons.search,
                      color: Colors.deepOrange,
                      size: Get.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          svg,
          Obx(
            () => controller.queryInitial.length == 0
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Get.height * 0.20),
                      child: Container(
                        height: Get.width * 0.7,
                        width: Get.width * 0.7,
                        child: Lottie.asset("assets/lottie/empty.json"),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.queryInitial.length,
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Get.width * 0.1,
                        ),
                        child: controller.queryInitial[index]["photoUrl"] ==
                                "noimage"
                            ? Image.asset(
                                "assets/logo/noimage.png",
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "${controller.queryInitial[index]["photoUrl"]}",
                                fit: BoxFit.cover,
                              ),
                      ),
                      title: Text(
                        '${controller.queryInitial[index]["name"]}',
                        style: TextStyle(
                          fontSize: Get.width * 0.050,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        '${controller.queryInitial[index]["email"]}',
                        style: TextStyle(
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      trailing: InkWell(
                        onTap: () => authC.addNewConnection(
                            controller.queryInitial[index]["email"]),
                        child: Chip(
                          backgroundColor: Colors.deepOrange.shade500,
                          label: Text(
                            'Message',
                            style: TextStyle(
                              fontSize: Get.width * 0.035,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
