import 'package:avatar_glow/avatar_glow.dart';
import 'package:deify/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../../../controllers/auth_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () =>Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>authC.logout(),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          svg,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AvatarGlow(
                  endRadius: Get.width * 0.25,
                  glowColor: Colors.white,
                  shape: BoxShape.circle,
                  duration: Duration(seconds: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Get.width*0.50,
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
            Obx(() => Text(
                "${authC.user.value.name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.width * 0.05,
                ),
              ),),
             Text(
                "${authC.user.value.email}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.width * 0.05,
                ),
             ),
              SizedBox(height: Get.height * 0.03),
              Container(
                child: Column(
                  children: [
                    ListTile(
                    onTap: () =>Get.toNamed(Routes.UPDATE_STATUS),
                leading: Icon(
                  Icons.note_add_outlined,
                  color: Colors.white,
                  size: Get.width * 0.1,
                ),
                title: Text(
                  "Change Status",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width * 0.07,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                  size: Get.width * 0.1,
                ),
              ),
                    ListTile(
                      onTap: () =>Get.toNamed(Routes.CHANGE_PROFILE),
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: Get.width * 0.1,
                      ),
                      title: Text(
                        'Update Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.width * 0.07,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: Get.width * 0.1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.color_lens,
                        color: Colors.white,
                        size: Get.width * 0.1,
                      ),
                      title: Text(
                        'Change Theme',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.width * 0.07,
                        ),
                      ),
                      trailing: Text(
                        'Light',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.25,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dating App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * 0.05,
                      ),
                    ),
                    Text(
                      "v.0.1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02
              ),
            ],
          ),

        ],
      ),
    );
  }
}
