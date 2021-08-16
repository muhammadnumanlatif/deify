import 'package:deify/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome",
            body: "To meet your Destiny.",
            decoration: PageDecoration(
              pageColor: Colors.deepOrange,
              imagePadding: EdgeInsets.only(
                top: Get.height*0.2,
              ),
              titleTextStyle: TextStyle(
                color:Colors.white,
                fontSize: Get.width*0.1
              ),
              bodyTextStyle:  TextStyle(
                color:Colors.white,
                  fontSize: Get.width*0.05
              ),
            ),
            image: Container(
              width: Get.width*0.8,
              height: Get.height*0.8,
              child: Center(
                child: Lottie.asset(
                    'assets/lottie/main-laptop-duduk.json',
                ),
              ),
            ),
          ),
          PageViewModel(
            title: "Connecting",
            body: "We help to meet people.",            image: Container(
              width: Get.width*0.6,
              height: Get.height*0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/ojek.json'),
              ),
            ),
            decoration: PageDecoration(
              pageColor: Colors.deepOrange,
              imagePadding: EdgeInsets.only(
                top: Get.height*0.2,
              ),
              titleTextStyle: TextStyle(
                  color:Colors.white,
                  fontSize: Get.width*0.1
              ),
              bodyTextStyle:  TextStyle(
                  color:Colors.white,
                  fontSize: Get.width*0.05
              ),
            ),
          ),
          PageViewModel(
            title: "Payment",
            body: "In app option is available.",
            image: Container(
              width: Get.width*0.6,
              height: Get.height*0.6,
              child: Center(
                child: Lottie.asset('assets/lottie/payment.json'),
              ),
            ),
            decoration: PageDecoration(
              pageColor: Colors.deepOrange,
              imagePadding: EdgeInsets.only(
                top: Get.height*0.2,
              ),
              titleTextStyle: TextStyle(
                  color:Colors.white,
                  fontSize: Get.width*0.1
              ),
              bodyTextStyle:  TextStyle(
                  color:Colors.white,
                  fontSize: Get.width*0.05
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
            decoration: PageDecoration(
              pageColor: Colors.deepOrange,
              imagePadding: EdgeInsets.only(
                top: Get.height*0.2,
              ),
              titleTextStyle: TextStyle(
                  color:Colors.white,
                  fontSize: Get.width*0.1
              ),
              bodyTextStyle:  TextStyle(
                  color:Colors.white,
                  fontSize: Get.width*0.05
              ),
            ),
          ),
        ],
        onDone: () => Get.offAllNamed(Routes.LOGIN),
        showSkipButton: true,
        globalBackgroundColor: Colors.deepOrange,
        dotsDecorator: DotsDecorator(
          color: Colors.amber.shade900,
          activeColor: Colors.white,

        ),
        skip: Text(
          "Skip",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: Get.width*0.05,
          ),
        ),
        next: Text(
          "Next",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            fontSize: Get.width*0.05,
          ),
        ),
        done: Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: Get.width*0.05
            ),
        ),
      ),
    );
  }
}