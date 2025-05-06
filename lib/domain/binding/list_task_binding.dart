import 'package:get/get.dart';
import 'package:task01/domain/controller/task_controller.dart';

class TaskListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
  }
}
