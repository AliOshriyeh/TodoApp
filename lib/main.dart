import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task01/configs/notification_service.dart';
import 'package:task01/data/providers/supabase_API.dart';
import 'package:task01/domain/controller/theme_controller.dart';
import 'package:task01/presentation/pages/spash_screen.dart';
import 'package:task01/presentation/theme/app_theme.dart';

import 'package:task01/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  await Supabase.initialize(url: SupabaseAPI.SUPABASE_URL, anonKey: SupabaseAPI.SUPABASE_PUB_KEY);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController _themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SpashScreen(),
      getPages: AppPages.routes,
    );
  }
}
