// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // boolean variable to check if a user is signed in or not ?
  var isSignedIn = false.obs;

  // Method for setting the isSignedIn variable to true
  // if ( isSignedIn=true ) THEN User goes to HomePage
  void signedIn() {
    isSignedIn.value = true;
  }

  // Method for setting the isSignedIn variable to false
  // if ( isSignedIn=false ) THEN User goes to SignIn Page
  void signedOut() {
    isSignedIn.value = false;
  }

  // On App Starts, Checking is a User Signed in or not
  // and this method will automatically called everytime when a User SignIn OR SignOut
  void checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        // redirecting to SignIn screen
        signedOut();
      } else {
        print('User is signed in!');
        // redirecting to HomePage screen
        signedIn();
      }
    });
  }
}
