// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/pages/sign_In/controller/signin_controller.dart';
import 'package:get/get.dart';

class FirebaseAuthenticationController extends GetxController {
  // using signInController here
  SignInController signInController = Get.put(SignInController());

  // Method for Creating & Storing User Email and Password in Firebase Authentication
  Future createUser(String email, String password) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Firebase', 'User Account Created Successfully !');
      print(credential);
      resetField();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar(
            'Account Status', 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Method for reseting the email & password field to Empty
  void resetField() {
    signInController.email.value = '';
    signInController.password.value = '';
    signInController.emailTextController.value.clear();
    signInController.passwordTextController.value.clear();
  }

  // Method for Signing in the User with their Email and Password
  Future signInUser(String email, String password) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Firebase', 'User Signed In !');
      print(credential);
      resetField();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
