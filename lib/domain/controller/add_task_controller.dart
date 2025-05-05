import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priorityController = TextEditingController(text: 'NORMAL');
  var selectedDate = DateTime.now().add(const Duration(days: 1)).obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
}
