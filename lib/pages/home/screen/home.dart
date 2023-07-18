// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/pages/sign_In/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // if User is signed in then user cannot go back
    // if user signed out then user will be redirected to Sign In Screen
    return WillPopScope(
      onWillPop: () {
        if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 100,
                  ),

                  /// Getting user name & email from Single specific Document
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth
                            .instance.currentUser?.uid) //ID OF DOCUMENT
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      var document = snapshot.data!;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Hello, ${document["name"]} !'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Your Email =  ${document["email"]}'),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // Button to Sign Out the User
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange[400])),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Get.to(() => const SignIn());
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  // Button to Delete the Currently Signed In User Account
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[400])),
                      onPressed: () async {
                        await FirebaseAuth.instance.currentUser?.delete();
                        Get.to(() => const SignIn());
                      },
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
