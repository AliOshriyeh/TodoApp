import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  // --- Form State ---
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priorityController = TextEditingController(text: 'NORMAL');

  // --- Date & Time Selection ---
  var selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  var selectedTime = TimeOfDay.now().obs;
  var isToday = false.obs; // Toggle for "today" selection

  // --- UI Update Methods ---
  void updateTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void toggleToday(bool value) {
    isToday.value = value;
    if (value) {
      selectedDate.value = DateTime.now();
    } else {
      selectedDate.value = DateTime.now().add(const Duration(days: 1));
    }
  }
}
