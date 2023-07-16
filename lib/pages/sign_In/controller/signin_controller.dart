import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  // text controllers for Email and Password Field
  var emailTextController = TextEditingController().obs;
  var passwordTextController = TextEditingController().obs;

  // variable to store email and password on Form Save
  var email = ''.obs;
  var password = ''.obs;

  // variable to check & uncheck (Remember Me) CheckBox
  var isChecked = false.obs;

  // method to check OR uncheck
  void isCheckedRememberMe() {
    if (isChecked.value == false) {
      isChecked.value = true;
    } else {
      isChecked.value = false;
    }
  }
}
