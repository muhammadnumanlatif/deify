import 'package:deify/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Remote Access",
            body: "This is standalone app to get remote access.",
            image: Container(
              width: Get.width*0.6,
              height: Get.height*0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/main-laptop-duduk.json'),
              ),
            ),
          ),
          PageViewModel(
            title: "Transport",
            body: "Different vehicle options are available.",            image: Container(
              width: Get.width*0.6,
              height: Get.height*0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/ojek.json'),
              ),
            ),
          ),
          PageViewModel(
            title: "Payment",
            body: "In app option is added.",
            image: Container(
              width: Get.width*0.6,
              height: Get.height*0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/payment.json'),
              ),
            ),
          ),
          PageViewModel(
            title: "Login",
            body: "Click to go on login.",
            image: Container(
              width: Get.width*0.6,
              height: Get.height*0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/register.json'),
              ),
            ),
          ),
        ],
        onDone: () => Get.offAllNamed(Routes.LOGIN),
        showSkipButton: true,
        skip: Text(
          "Skip",
        ),
        next: Text(
          "Next",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        done: Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.w600,
            ),
        ),
      ),
    );
  }
}
