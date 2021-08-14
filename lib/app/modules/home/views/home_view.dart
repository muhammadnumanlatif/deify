import 'package:deify/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  final List<Widget> myChats = List.generate(
    20,
    (index) => InkWell(
      
      child: ListTile(
        onTap: ()=>Get.toNamed(Routes.CHAT_ROOM),
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange.shade500,
          backgroundImage: AssetImage(
              'assets/logo/noimage.png',
          ),
        ),
        title: Text(
          'Person ${index + 1}',
          style: TextStyle(
            fontSize: Get.width*0.050,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          'Status ${index + 1}',
          style: TextStyle(
            fontSize: Get.width*0.035,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        trailing: Chip(
          backgroundColor: Colors.deepOrange.shade500,
          label: Text(
            '3',
            style: TextStyle(
              fontSize: Get.width * 0.035,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  ).reversed.toList();
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
                      color: Colors.white70,
                      width: Get.width*0.005
                    ),
                  ),
                ),
                // color: Colors.deepOrange.shade500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: Get.width*0.12,
                        color: Colors.white,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: ()=>Get.toNamed(Routes.PROFILE),
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
                child: ListView.builder(
                 padding: EdgeInsets.zero,
                  itemCount: myChats.length,
                  itemBuilder: (context, index) => myChats[index],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Get.toNamed(Routes.SEARCH),
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