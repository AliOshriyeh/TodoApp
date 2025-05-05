// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/configs/util.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/add_task_controller.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  final controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                TextFormField(
                    controller: controller.titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    validator: requiredFieldValidator),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  maxLines: 3,
                  validator: requiredFieldValidator,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: controller.priorityController.text,
                  borderRadius: BorderRadius.circular(20),
                  items: ['HIGH', 'NORMAL', 'LOW']
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.priorityController.text = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Due Date'),
                  subtitle: Text('${controller.selectedDate.value.toLocal()}'.split(' ')[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _showCupertinoDatePicker(context),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Save Task', style: AppTextStyle.black16.copyWith(color: AppColors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCupertinoDatePicker(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now().add(const Duration(days: 1)),
                minimumDate: DateTime.now(),
                maximumDate: DateTime(2101),
                onDateTimeChanged: (DateTime newDate) {
                  controller.updateDate(newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    if (!controller.formKey.currentState!.validate()) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }
    final newTask = TaskModel(
      id: -1, // Will be auto-incremented
      title: controller.titleController.text,
      desc: controller.descController.text,
      crt_date: DateTime.now(),
      exp_date: controller.selectedDate.value,
      priority: controller.priorityController.text,
      status: 'INCOMPLETE',
    );

    await Get.find<TaskController>().insertTask(newTask);
  }
}
