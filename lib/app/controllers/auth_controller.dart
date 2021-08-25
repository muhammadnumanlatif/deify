import 'package:deify/app/data/models/chats_model.dart';
import 'package:deify/app/data/models/users_model.dart';
import 'package:deify/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var chat = Chats().obs;

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
  } //*end

  //*skipIntro method
  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  } //*end

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

        await users.doc(_currentUser!.email).update({
          "lastSignInTime":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        // add to user user model
        user(UsersModel(
          creationTime: currUserData["creationTime"],
          email: currUserData["email"],
          keyName: currUserData["keyName"],
          lastSignInTime: currUserData["lastSignInTime"],
          name: currUserData["name"],
          photoUrl: currUserData["photoUrl"],
          status: currUserData["status"],
          uid: currUserData["uid"],
          updatedTime: currUserData["updatedTime"],
          chats: [],
        ));

        //* firebase user chats
        final listChats = await users.doc(_currentUser!.email).collection('chats').get();
        if(listChats.docs.length!=0){
          List<ChatUser> dataListChats = List<ChatUser>.empty();
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });
          //*model user chats
          user.update((user) {
            user!.chats = dataListChats;
          });
        }else{
          //*model user chats
          user.update((user) {
            user!.chats = [];
          });
        }

        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  } //*end

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
          await users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "keyName": _currentUser!.displayName!.substring(0, 1).toUpperCase(),
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl ?? "noimage",
            "status": "",
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String(),
          });
          //chats
          await users.doc(_currentUser!.email).collection("chats");
        } else {
          await users.doc(_currentUser!.email).update({
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }
        //*current user
        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        // add to user user model
        user(UsersModel(
          creationTime: currUserData["creationTime"],
          email: currUserData["email"],
          keyName: currUserData["keyName"],
          lastSignInTime: currUserData["lastSignInTime"],
          name: currUserData["name"],
          photoUrl: currUserData["photoUrl"],
          status: currUserData["status"],
          uid: currUserData["uid"],
          updatedTime: currUserData["updatedTime"],
          chats: [],
        ));

        //* firebase user chats
        final listChats = await users.doc(_currentUser!.email).collection('chats').get();
        if(listChats.docs.length!=0){
          List<ChatUser> dataListChats = List<ChatUser>.empty();
        listChats.docs.forEach((element) {
          var dataDocChat = element.data();
          var dataDocChatId = element.id;
          dataListChats.add(ChatUser(
            chatId: dataDocChatId,
            connection: dataDocChat["connection"],
            lastTime: dataDocChat["lastTime"],
            total_unread: dataDocChat["total_unread"],
          ));
        });
        //*model user chats
          user.update((user) {
            user!.chats = dataListChats;
          });
        }else{
          //*model user chats
          user.update((user) {
            user!.chats = [];
          });
        }

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      } else {
        printInfo(info: "Error Logged In");
      }
    } catch (error) {
      printInfo(info: error.toString());
    }
  } //*end

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
  ) {
    //*var
    String date = DateTime.now().toIso8601String();

    //*update firebase
    CollectionReference users = firestore.collection('users');
    users.doc(_currentUser!.email).update({
      "name": name,
      "keyName": name.substring(0, 1).toUpperCase(),
      "status": status,
      "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": DateTime.now().toIso8601String()
    });

    //*update model
    user.update((user) {
      user!.name = name;
      user.keyName = name.substring(0, 1).toUpperCase();
      user.status = status;
      user.lastSignInTime =
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
  } //*end

  //*update status
  void updateStatus(String status) {
    //*var
    String date = DateTime.now().toIso8601String();
    //*update firebase
    CollectionReference users = firestore.collection('users');
    users.doc(_currentUser!.email).update({
      "status": status,
      "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": date
    });

    //*update model
    user.update((user) {
      user!.status = status;
      user.lastSignInTime =
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
  } //*end

//*search
  void addNewConnection(String friendEmail) async {
    bool flagNewConnection = false;
    var chat_id;
    String date = DateTime.now().toIso8601String();
    CollectionReference chats = firestore.collection("chats");
    CollectionReference users = firestore.collection("users");

    final docChats = await users.doc(_currentUser!.email).collection("chats").get();

    if(docChats.docs.length!=0){
      //*not add new connection
     final checkConnection = await users.doc(_currentUser!.email).collection("chats")
          .where("connection", isEqualTo: friendEmail)
          .get();
     //*connection condition
      if(checkConnection.docs.length != 0){
        flagNewConnection=false;

        //* chat_id from chat collections
       chat_id = checkConnection.docs[0].id;


      }else{
        //*add new connection
        flagNewConnection = true;
      }

    } else{
      //*add new connection
      flagNewConnection = true;
    }

    //*flag New Connection True
    if(flagNewConnection == true){

      final chatsDocs = await chats.where(
        "connections",
        whereIn: [
          [
            _currentUser!.email,
            friendEmail,
          ],
          [
            friendEmail,
            _currentUser!.email,
          ],
        ],
      ).get();

      if(chatsDocs.docs.length != 0){
        final chatsData =  chatsDocs.docs[0].data() as Map<String, dynamic>;
        final chatDataId  = chatsDocs.docs[0].id;

        //*user firebase
        await users.doc(_currentUser!.email)
            .collection("chats")
            .doc(chatDataId)
            .set({
          "connection": friendEmail,
          "chat_id": chatDataId,
          "lastTime": chatsData["lastTime"],
          "total_unread": 0,
        });

        //* firebase user chats
        final listChats = await users.doc(_currentUser!.email).collection('chats').get();
        if(listChats.docs.length!=0){
          List<ChatUser> dataListChats = List<ChatUser>.empty();
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });
          //*model user chats
          user.update((user) {
            user!.chats = dataListChats;
          });
        }else{
          //*model user chats
          user.update((user) {
            user!.chats = [];
          });
        }

        chat_id = chatDataId;
        user.refresh();
      }else {
        //*chat firebase
        final newChatDoc = await chats.add({
          "connections": [
            _currentUser!.email,
            friendEmail,
          ],
          "chat": [],
        });

        //*user firebase
        await users.doc(_currentUser!.email)
            .collection("chats")
            .doc(newChatDoc.id)
        .set({
          "connection": friendEmail,
          "chat_id": newChatDoc.id,
          "lastTime": date,
          "total_unread": 0,
        });

        //* firebase user chats
        final listChats = await users.doc(_currentUser!.email).collection('chats').get();
        if(listChats.docs.length!=0){
          List<ChatUser> dataListChats = List<ChatUser>.empty();
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });
          //*model user chats
          user.update((user) {
            user!.chats = dataListChats;
          });
        }else{
          //*model user chats
          user.update((user) {
            user!.chats = [];
          });
        }

        chat_id = newChatDoc.id;
        user.refresh();
      }

    }
    print(chat_id);
    //*got to chat room
    Get.toNamed(Routes.CHAT_ROOM,arguments: chat_id);

  } //*addNewConnection

} //*end
