import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // TextEditing Controller for User Name, Email, Password
  var userNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  // variable to store user name, email, password on form save
  var userName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
}
