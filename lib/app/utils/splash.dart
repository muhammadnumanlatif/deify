import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Stack(
          children: [
            svg,
            Center(
              child: Container(
                height: Get.width*0.7,
                width: Get.width*0.7,
                child: Lottie.asset('assets/lottie/hello.json')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
