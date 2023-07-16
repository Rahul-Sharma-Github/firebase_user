import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/pages/sign_In/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => const SignIn());
              },
              child: const Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
