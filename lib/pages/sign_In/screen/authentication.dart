// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/pages/home/screen/home.dart';
import 'package:firebase_user/pages/sign_In/controller/signin_controller.dart';
import 'package:get/get.dart';

import '../../../main_controller.dart';
import '../../sign_Up/controller/signup_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthenticationController extends GetxController {
  // using signInController here
  SignInController signInController = Get.put(SignInController());

  // using SignUpController here
  SignUpController signUpController = Get.put(SignUpController());

  MainController mainController = Get.put(MainController());

  // Method for Creating & Storing User Email and Password in Firebase Authentication
  Future createUser(String name, String email, String password) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Firebase', 'User Account Created Successfully !');
      print(credential);
      final uid = credential.user?.uid;

      // Storing User Account Data to Cloud Firestore
      saveUser(name, email, uid);

      // field reset
      resetSignUpField();

      Get.to(() => const HomePage());
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
  void resetSignUpField() {
    signUpController.userName.value = '';
    signUpController.email.value = '';
    signUpController.password.value = '';

    signUpController.userNameController.value.clear();
    signUpController.emailController.value.clear();
    signUpController.passwordController.value.clear();
  }

  // Method for Signing in the User with their Email and Password
  Future signInUser(String email, String password) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Firebase', 'User Signed In !');
      print(credential);
      resetSignInField();

      Get.to(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Method for reseting the email & password field to Empty
  void resetSignInField() {
    signInController.email.value = '';
    signInController.password.value = '';

    signInController.emailTextController.value.clear();
    signInController.passwordTextController.value.clear();
  }

  /// Firebase Cloud Firestore Logics

  // Method for storing user account information to cloud firestore
  // storing data according to uid of that user account
  Future saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'name': name, 'email': email});

    Get.snackbar('Firebase', 'User Account Data Stored in Database !');
  }
}
