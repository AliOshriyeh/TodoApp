import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/routes/app_routes.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';

class SpashScreen extends StatelessWidget {
  const SpashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: SelectableLinkify(text: "Gifs Made by https://storyset.com/book", textAlign: TextAlign.center),
        // ),
        body: FlutterSplashScreen.fadeIn(
            childWidget: const Center(child: Icon(Icons.note_alt_rounded, color: AppColors.black, size: 200)),
            backgroundColor: Colors.white,
            asyncNavigationCallback: () async {
              await Future.delayed(const Duration(seconds: 3));
              if (context.mounted) {
                Get.offNamed(AppRoutes.signin);
              }
            }));
  }
}
