import 'package:barokah_cars_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BaroCars Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: const Scaffold(),
    ),
  );
}
