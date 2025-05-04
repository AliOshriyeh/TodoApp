import 'package:get/get.dart';
import 'package:task01/domain/binding/auth_binding.dart';
import 'package:task01/presentation/pages/auth_page.dart';
import 'package:task01/presentation/pages/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      binding: AuthBinding(),
      name: AppRoutes.authentication,
      page: () => AuthPage(),
    ),
  ];
}
