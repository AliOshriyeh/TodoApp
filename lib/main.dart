import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task01/data/providers/supabase_API.dart';

import 'package:task01/presentation/theme/app_theme.dart';
import 'package:task01/presentation/pages/spash_screen.dart';

import 'package:task01/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SupabaseAPI.SUPABASE_URL, anonKey: SupabaseAPI.SUPABASE_PUB_KEY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //FIXME -  SystemChannels.textInput.invokeMethod('TextInput.hide');
    return GetMaterialApp(
      theme: appThemeData,
      debugShowCheckedModeBanner: false,
      home: const SpashScreen(),
      getPages: AppPages.routes,
    );
  }
}
