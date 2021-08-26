import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/update_status_controller.dart';
import '../../../controllers/auth_controller.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
  final Widget svg = SvgPicture.asset(
    'assets/logo/deify.svg',
    fit: BoxFit.cover,
  );
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.statusC.text=authC.user.value.status!;
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(
              Icons.arrow_back,
          color: Colors.white,
          ),
        ),
        title: Text('Update Status'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          svg,
          Padding(
            padding: EdgeInsets.symmetric(
            vertical:Get.height*0.05,
              horizontal: 22,
            ),
            child: Column(
              children: [
                TextField(
                  controller: controller.statusC,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: (){
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                      currentFocus.focusedChild!.unfocus();
                    }
                    authC.updateStatus(controller.statusC.text);
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width*0.05,
                  ),
                  decoration: InputDecoration(
                    labelText: "Status",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width*0.05,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width*0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Get.width*0.12,
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width*0.05,
                      vertical: Get.height*0.012
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height*0.03,
                ),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed: (){
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                        currentFocus.focusedChild!.unfocus();
                      }
                      authC.updateStatus(controller.statusC.text);
                    },
                    child: Text(
                        "Update",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: Get.width*0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Get.width*0.12,
                        ),

                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width*0.05,
                          vertical: Get.height*0.012
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
