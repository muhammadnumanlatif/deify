import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Center(
          child: Container(
            height: Get.width*0.7,
            width: Get.width*0.7,
            color: Colors.deepOrange,
            child: Lottie.asset('assets/lottie/hello.json')
          ),
        ),
      ),
    );
  }
}
