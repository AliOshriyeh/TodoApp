import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/task_controller.dart';

class EditTaskController extends GetxController {
  // --- Dependencies ---
  final TaskController taskController = Get.find<TaskController>();

  // --- Form State ---
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priorityController = TextEditingController();
  final selectedDate = Rx<DateTime>(DateTime.now());
  final status = Rx<String>('INCOMPLETE'); // Task status

  // --- Initialization ---
  void initializeWithTask(TaskModel task) {
    titleController.text = task.title;
    descController.text = task.desc;
    priorityController.text = task.priority;
    selectedDate.value = task.exp_date;
    status.value = task.status;
  }

  // --- Task Operations ---
  Future<void> updateTask(TaskModel originalTask) async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    final updatedTask = TaskModel(
      id: originalTask.id,
      title: titleController.text,
      desc: descController.text,
      crt_date: originalTask.crt_date,
      exp_date: selectedDate.value,
      priority: priorityController.text,
      status: status.value,
    );

    await taskController.updateTask(updatedTask);
  }

  @override
  void onClose() {
    // Clean up controllers
    titleController.dispose();
    descController.dispose();
    priorityController.dispose();
    super.onClose();
  }
}
