// ignore_for_file: avoid_print

import 'package:firebase_user/pages/home/screen/home.dart';
import 'package:firebase_user/pages/sign_In/screen/sign_in.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:get/get.dart';

import 'main_controller.dart';

import 'package:device_preview/device_preview.dart';

// it will initialize and connect our Flutter Firebase app before starting the App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // initializing MainController
  MainController mainController = Get.put(MainController());

  //On App Starts, Checking is a User Signed in or not
  @override
  void initState() {
    super.initState();
    mainController.checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // if User already Signed in then User will Redirected to HomePage
        // if User not Signed in, then User will Redirected to SignIn Page
        // where you can SignIn a user and also can go to RegisterPage to Register as a New User
        body: Obx(
          () => SafeArea(
            child: mainController.isSignedIn.value
                ? const HomePage()
                : const SignIn(),
          ),
        ),
      ),
    );
  }
}
