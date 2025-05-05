import 'package:get/get.dart';
import 'package:task01/domain/binding/auth_binding.dart';
import 'package:task01/presentation/pages/add_task_page.dart';
import 'package:task01/presentation/pages/signin_page.dart';
import 'package:task01/presentation/pages/signup_page.dart';
import 'package:task01/presentation/pages/list_task_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      binding: AuthBinding(),
      name: AppRoutes.signin,
      page: () => SignInPage(),
    ),
    GetPage(
      binding: AuthBinding(),
      name: AppRoutes.signup,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.tasklist,
      page: () => TaskListPage(),
    ),
    GetPage(
      name: AppRoutes.tasklist,
      page: () => AddTaskPage(),
    ),
  ];
}
