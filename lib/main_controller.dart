// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // boolean variable to check if a user is signed in or not ?
  var isSignedIn = false.obs;

  // Method for setting the isSignedIn variable to true

  void signedIn() {
    isSignedIn.value = true;
  }

  // Method for setting the isSignedIn variable to false
  void signedOut() {
    isSignedIn.value = false;
  }

  void checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        signedOut();
      } else {
        print('User is signed in!');
        signedIn();
      }
    });
  }
}
