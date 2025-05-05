import 'package:get/get.dart';
import 'package:task01/domain/controller/edit_task_controller.dart';

class EditTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditTaskController());
  }
}
