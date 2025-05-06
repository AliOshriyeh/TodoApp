import 'package:get/get.dart';
import 'package:task01/domain/binding/auth_binding.dart';
import 'package:task01/domain/binding/list_task_binding.dart';
import 'package:task01/presentation/pages/signin_page.dart';
import 'package:task01/presentation/pages/signup_page.dart';
import 'package:task01/presentation/pages/list_task_page.dart';
import 'app_routes.dart';

class AppPages {
  // --- Application Routes Configuration ---
  static final routes = [
    // Authentication Pages
    GetPage(
      binding: AuthBinding(), // Dependency injection for auth
      name: AppRoutes.signin, // Route name
      page: () => SignInPage(), // Page widget
    ),
    GetPage(
      binding: AuthBinding(),
      name: AppRoutes.signup,
      page: () => SignUpPage(),
    ),

    // Task Management Pages
    GetPage(
      binding: TaskListBinding(), // Dependency injection for tasks
      name: AppRoutes.tasklist,
      page: () => TaskListPage(),
    ),
  ];
}
