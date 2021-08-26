import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../controllers/change_profile_controller.dart';
import 'package:deify/app/controllers/auth_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Change Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
              authC.changeProfile(
                controller.nameC.text,
                controller.statusC.text,
              );
            },
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          svg,
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
              horizontal: 22,
            ),
            child: Column(
              children: [
                Flexible(
                  child: AvatarGlow(
                    endRadius: Get.width * 0.25,
                    glowColor: Colors.white,
                    shape: BoxShape.circle,
                    duration: Duration(seconds: 2),
                    child: Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Get.width * 0.50,
                        ),
                        child: authC.user.value.photoUrl == "noimage"
                            ? Image.asset(
                                'assets/logo/noimage.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "${authC.user.value.photoUrl}",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                TextField(
                  controller: controller.emailC,
                  cursorColor: Colors.white,
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width * 0.05,
                  ),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.05,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width * 0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width * 0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.012),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                TextField(
                  controller: controller.nameC,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width * 0.05,
                  ),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.05,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width * 0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width * 0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.012),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                TextField(
                  controller: controller.statusC,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                      currentFocus.focusedChild!.unfocus();
                    }
                    authC.changeProfile(
                      controller.nameC.text,
                      controller.statusC.text,
                    );
                  },
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width * 0.05,
                  ),
                  decoration: InputDecoration(
                    labelText: "Status",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.05,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width * 0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width * 0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.012),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "no image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(
                        "Choosen..",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        currentFocus.focusedChild!.unfocus();
                      }
                      authC.changeProfile(
                        controller.nameC.text,
                        controller.statusC.text,
                      );
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: Get.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Get.width * 0.12,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.height * 0.012),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
