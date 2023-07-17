// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:firebase_user/pages/sign_Up/screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/signin_controller.dart';
import 'authentication.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    // initializing the SignInController
    SignInController signinController = Get.put(SignInController());

    // initializing the FirebaseAuthenticationController
    FirebaseAuthenticationController authenticationController =
        Get.put(FirebaseAuthenticationController());

    // global form key for Sign In Form
    GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();

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
                  'Log In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),

                // Sign In Form
                Form(
                  key: formKeySignIn,
                  child: Column(
                    children: [
                      // Email Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: TextFormField(
                          controller:
                              signinController.emailTextController.value,
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
                            signinController.email.value = newValue!;
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
                          controller:
                              signinController.passwordTextController.value,
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
                            signinController.password.value = newValue!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Remember Me checkbox & Forgot Password
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Obx(
                              () => Checkbox.adaptive(
                                value: signinController.isChecked.value,
                                onChanged: (value) {
                                  signinController.isCheckedRememberMe();
                                },
                              ),
                            ),
                            const Text('Remember Me'),
                          ],
                        ),
                      ),
                      InkWell(
                        child: const Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                // Log In Button
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
                      // checking if the Sign In Form Valid or Not ?
                      // if valid then Saving the form
                      // and Login with the Email and Password
                      if (formKeySignIn.currentState!.validate()) {
                        formKeySignIn.currentState?.save();
                        print('Form is Valid.');
                        print(signinController.email.value);
                        print(signinController.password.value);

                        // Signing In the User Account through Firebase Authentication Feature
                        authenticationController.signInUser(
                          signinController.email.value.toString(),
                          signinController.password.value.toString(),
                        );
                      }
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                // Route to Sign Up / Register Form
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 20),
                    child: Row(
                      children: [
                        const Text("Don't have an account?"),
                        InkWell(
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                          onTap: () {
                            Get.to(() => const SignUp());
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
