import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // --- Theme State ---
  var isDarkMode = false.obs; // Dark mode toggle state

  // --- Theme Methods ---
  void toggleTheme() async {
    isDarkMode.toggle();
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );

    update(); // Force update all GetBuilder widgets
  }
}
