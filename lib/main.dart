import 'package:flutter/material.dart';
import 'home.dart';
import 'package:get/get.dart';
import 'controllers/user_controller.dart';

void main() {
  Get.put(UserController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}