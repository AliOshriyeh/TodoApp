// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task01/domain/controller/auth_controller.dart';
import 'package:task01/presentation/pages/auth_page.dart';
import 'package:task01/presentation/pages/home_page.dart';

class AuthWrapper extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.user != null) {
        return HomePage();
      } else {
        return AuthPage();
      }
    });
  }
}
