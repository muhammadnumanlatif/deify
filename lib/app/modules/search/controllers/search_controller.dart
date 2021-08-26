import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  late TextEditingController searchC;

  var queryInitial = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchFriend(
    String data,
    String email,
  ) async {
    print("SEARCH : $data");

    if (data.length == 0) {
      queryInitial.value = [];
      tempSearch.value = [];
    } else {
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      print(capitalized);
      if (queryInitial.length == 0 && data.length == 1) {
        CollectionReference users = await firestore.collection("users");
        final keyNameResult = await users
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .where("email", isNotEqualTo: email)
            .get();

        print("Total Data: ${keyNameResult.docs.length}");
        if (keyNameResult.docs.length > 0) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryInitial
                .add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          print("Query Result: ");
          print(queryInitial);
        } else {
          print("No Result");
        }
      }
      // tempSearch = [];

      if (queryInitial.length != 0) {
        queryInitial.forEach((element) {
          if (element["name"].startsWith(data.substring(0, 1).toUpperCase() + data.substring(1))) {
            tempSearch.add(element);
          }
        });
      }
    }

    queryInitial.refresh();
    tempSearch.refresh();
    print("Temp: ${tempSearch.length}");

  }

  @override
  void onInit() {
    searchC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
