import 'package:deify/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {

  final authC = Get.find<AuthController>();

  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leadingWidth: Get.width * 0.23,
        leading: InkWell(
          onTap: () => Get.back(),
          splashColor: Colors.deepOrange,
          borderRadius: BorderRadius.circular(Get.width * 0.25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () =>Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.deepOrange.shade400,
                radius: Get.width * 0.05,
                backgroundImage: AssetImage('assets/logo/noimage.png'),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UserName',
              style: TextStyle(
                fontSize: Get.width * 0.050,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              'username@gmail.com',
              style: TextStyle(
                fontSize: Get.width * 0.050,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: (){
          if(controller.isShowEmoji.isTrue){
            controller.isShowEmoji.value=false;
          }else{
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Stack(
          children: [
            svg,
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        //*1
                        ItemChat(
                          isSender: true,
                        ),
                        //*12
                        ItemChat(
                          isSender: false,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: controller.isShowEmoji.isTrue
                    ?5
                    :context.mediaQueryPadding.bottom,
                  ),
                  width: Get.width,
                  height: Get.height * 0.08,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04,
                    vertical: Get.width * 0.025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            right: Get.width * 0.02,
                          ),
                          child: TextField(
                            controller: controller.chatC,
                            focusNode: controller.focusNode,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03,
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  controller.focusNode.unfocus();
                                  controller.isShowEmoji.toggle();
                                },
                                splashColor: Colors.amber,
                                icon: Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.12),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.12),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.deepOrange,
                        onTap: () => controller.newChat(
                            authC.user.value.email!,
                            Get.arguments as Map<String, dynamic>,
                            controller.chatC.text,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: Get.width * 0.05,
                          child: Icon(
                            Icons.send,
                            color: Colors.deepOrange,
                            size: Get.width * 0.06,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => controller.isShowEmoji.isTrue
                    ? Container(
                        height: Get.height * 0.32,
                        child: EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            controller.addEmoji(emoji);
                          },
                          onBackspacePressed: () {
                            // Backspace-Button tapped logic
                            // Remove this line to also remove the button in the UI
                            controller.deleteEmoji();
                          },
                          config: Config(
                            columns: 7,
                            emojiSizeMax: Get.width * 0.1,
                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            backspaceColor: Colors.deepOrange,
                            initCategory: Category.RECENT,
                            bgColor: Color(0xFFF2F2F2),
                            indicatorColor: Colors.deepOrange,
                            iconColor: Colors.grey,
                            iconColorSelected: Colors.deepOrange,
                            progressIndicatorColor: Colors.deepOrange,
                            showRecentsTab: true,
                            recentsLimit: 28,
                            noRecentsText: "No Recents",
                            noRecentsStyle: TextStyle(
                              fontSize: Get.width * 0.05,
                              color: Colors.deepOrange,
                            ),
                            categoryIcons: const CategoryIcons(),
                            buttonMode: ButtonMode.MATERIAL,
                          ),
                        ),
                      )
                    : Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
  }) : super(key: key);
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.025,
        vertical: Get.width * 0.025,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isSender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(Get.width * 0.03),
                      topRight: Radius.circular(Get.width * 0.03),
                      bottomLeft: Radius.circular(Get.width * 0.03),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(Get.width * 0.03),
                      topRight: Radius.circular(Get.width * 0.03),
                      bottomRight: Radius.circular(Get.width * 0.03),
                    ),
            ),
            padding: EdgeInsets.all(Get.width * 0.025),
            child: Text(
              'Hello World',
              style: TextStyle(
                fontSize: Get.width * 0.050,
                color: Colors.deepOrange,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.003,
          ),
          Text(
            '18:22 PM',
            style: TextStyle(
              fontSize: Get.width * 0.040,
              color: Colors.white,
            ),
          ),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
