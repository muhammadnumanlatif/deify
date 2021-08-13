import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: (Get.width*0.20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.7,
                  height: Get.width * 0.7,
                  child: Lottie.asset("assets/lottie/login.json"),
                ),
                SizedBox(
                  height: Get.height * 0.15,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                          FontAwesomeIcons.google,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: Get.width*0.02,
                      ),
                      Flexible(
                        child: Text(
                          "Sign In with with Google",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: Get.width*0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height*0.02
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
