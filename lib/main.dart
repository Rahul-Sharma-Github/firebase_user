// ignore_for_file: avoid_print

import 'package:firebase_user/pages/home/screen/home.dart';
import 'package:firebase_user/pages/sign_In/screen/sign_in.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:get/get.dart';

import 'main_controller.dart';

// it will initialize our Flutter Firebase app before starting the App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MainController mainController = Get.put(MainController());
  @override
  void initState() {
    super.initState();

    print('initState() called.');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        body:
            mainController.isSignedIn.value ? const HomePage() : const SignIn(),
      ),
    );
  }
}
