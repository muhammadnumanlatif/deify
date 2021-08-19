import 'package:deify/app/data/models/users_model_model.dart';
import 'package:deify/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {

  //*variable
  var isSkipIntro = false.obs;
  var isAuth = false.obs;
  var user = UsersModel().obs;

  //*instance
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //*initialized method
  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });

    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  //*skipIntro method
  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  }

  //*autoLogin method
  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
        final _googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        CollectionReference users = firestore.collection('users');

        users.doc(_currentUser!.email).update({
          "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;
        user(UsersModel(
          uid: currUserData["uid"],
          name: currUserData["name"],
          email: currUserData["email"],
          photoUrl: currUserData["photoUrl"],
          status: currUserData["status"],
          creationTime: currUserData["creationTime"],
          lastSignInTime: currUserData["lastSignInTime"],
          updatedTime: currUserData["updatedTime"],
        ));

        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  //*login method
  Future<void> login() async {
    //try
    try {
      //*sign out
      await _googleSignIn.signOut();
      //*sign in
      await _googleSignIn.signIn().then((value) => _currentUser = value);
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        final _googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);
        //*local storage
        final box = GetStorage();
        if (box.read('skipIntro') != null) {
          box.remove('skipIntro');
        }
        box.write('skipIntro', true);
        //*firestore instance
        CollectionReference users = firestore.collection('users');
        //*get user
        final checkUser = await users.doc(_currentUser!.email).get();
        if (checkUser.data() == null) {
          users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl ?? "noimage",
            "status": "",
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime":
                userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String(),
          });
        } else {
          users.doc(_currentUser!.email).update({
            "lastSignInTime":
                userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
          });
        }
        //*current user
        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;
        //*add to user user model
        user(UsersModel(
          uid: currUserData["uid"],
          name: currUserData["name"],
          email: currUserData["email"],
          photoUrl: currUserData["photoUrl"],
          status: currUserData["status"],
          creationTime: currUserData["creationTime"],
          lastSignInTime: currUserData["lastSignInTime"],
          updatedTime: currUserData["updatedTime"],
        ));
        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      } else {
        printInfo(info: "Error Logged In");
      }
    } catch (error) {
      printInfo(info: error.toString());
    }
  }

  //*logout method
  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  //change profile method
  void changeProfile(
      String name,
      String status,
      ){
    //*var
    String date = DateTime.now().toIso8601String();

    //*update firebase
    CollectionReference users = firestore.collection('users');
    users.doc(_currentUser!.email).update({
      "name": name,
      "status": status,
      "lastSignInTime":
      userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": DateTime.now().toIso8601String()
    });

    //*update model
    user.update((user) {
      user!.name=name;
      user.status=status;
      user.lastSignInTime=
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });

    user.refresh();
    Get.snackbar(
      'Update',
      "Profile has been updated.",
      backgroundColor: Colors.white,
      colorText: Colors.deepOrange,
    );
  }

  //*update status
  void updateStatus(String status){
    //*var
    String date = DateTime.now().toIso8601String();
    //*update firebase
    CollectionReference users = firestore.collection('users');
    users.doc(_currentUser!.email).update({
      "status": status,
      "lastSignInTime":
      userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime":date
    });

    //*update model
    user.update((user) {
      user!.status=status;
      user.lastSignInTime=
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });

    user.refresh();
    Get.snackbar(
      'Update',
      "Status has been updated.",
      backgroundColor: Colors.white,
      colorText: Colors.deepOrange,
    );
  }

  //*end
}
