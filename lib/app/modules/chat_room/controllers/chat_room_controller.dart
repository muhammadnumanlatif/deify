import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class ChatRoomController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isShowEmoji = false.obs;
 late FocusNode focusNode;
 late TextEditingController chatC;

 void addEmoji(Emoji emoji){
   chatC.text = chatC.text + emoji.emoji;
 }

 void newChat(
     String email,
     Map<String, dynamic> arguments,
     String chat
     ){
  CollectionReference chats = firestore.collection("chats");
  chats.doc(arguments["chat_id"]).collection("chat").add({
    "sender": email,
    "receiver":arguments["friendEmail"],
    "message": chat,
    "time":  DateTime.now().toIso8601String(),
    "isRead": false
  });
 }

 void deleteEmoji(){
   chatC.text = chatC.text.substring(0,chatC.text.length-2);
 }

  @override
  void onInit() {
   chatC =TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        isShowEmoji.value=false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
   chatC.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
