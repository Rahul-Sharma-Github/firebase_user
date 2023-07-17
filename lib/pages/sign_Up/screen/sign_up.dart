// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:firebase_user/pages/sign_In/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../sign_In/screen/authentication.dart';
import '../controller/signup_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // initializing the SignUpController
    SignUpController signUpController = Get.put(SignUpController());

    // initializing the FirebaseAuthenticationController
    FirebaseAuthenticationController authenticationController =
        Get.put(FirebaseAuthenticationController());

    // global form key for Sign Up Form
    GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Part
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'To continue, Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),

                // Form for Sign Up Process
                Form(
                  key: formKeySignUp,
                  child: Column(
                    children: [
                      // User Name Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: TextFormField(
                          controller: signUpController.userNameController.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your User Name !';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            signUpController.userName.value = newValue!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Email Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: TextFormField(
                          controller: signUpController.emailController.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Email !';
                            } else if (!value.contains('@')) {
                              return 'please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            signUpController.email.value = newValue!;
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Password Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: TextFormField(
                          controller: signUpController.passwordController.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be 6 character long !';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            signUpController.password.value = newValue!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                // Sign Up Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 15),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // checking if the Sign Up Form Valid or Not ?
                      // if valid then Saving the form
                      // and Creating a New User Account
                      if (formKeySignUp.currentState!.validate()) {
                        formKeySignUp.currentState?.save();
                        print('Form is Valid.');
                        print(signUpController.userName.value);
                        print(signUpController.email.value);
                        print(signUpController.password.value);

                        // Creating user through Firebase Authentication Feature
                        authenticationController.createUser(
                          signUpController.userName.value.toString(),
                          signUpController.email.value.toString(),
                          signUpController.password.value.toString(),
                        );
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                // Route to Sign In/ Log In Form
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 20),
                    child: Row(
                      children: [
                        const Text("Already have an account?"),
                        InkWell(
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                          onTap: () {
                            Get.to(() => const SignIn());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
