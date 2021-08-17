import 'package:deify/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  Future<void> login() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _currentUser = value);
     final isSignIn = await _googleSignIn.isSignedIn();
    if(isSignIn){
      final _googleAuth = await _currentUser!.authentication;
      final credential = GoogleAuthProvider.credential(
         idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      isAuth.value = true;
      Get.offAllNamed(Routes.HOME);
    } else {
          printInfo(info: "Error Logged In");
        }
    } catch (error) {
      printInfo(info: error.toString());
    }}

  Future<void> logout() async{
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
