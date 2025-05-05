// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/edit_task_controller.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';

class EditTaskPage extends StatelessWidget {
  final TaskModel task;

  const EditTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditTaskController>();
    controller.initializeWithTask(task);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  maxLines: 3,
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
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate.value,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != controller.selectedDate.value) {
                      controller.selectedDate.value = picked;
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: controller.status.value,
                  borderRadius: BorderRadius.circular(20),
                  items: ['INCOMPLETE', 'COMPLETE']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.status.value = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => _updateTask(controller, task),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Update Task', style: AppTextStyle.black16.copyWith(color: AppColors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _updateTask(EditTaskController controller, TaskModel task) async {
  await controller.updateTask(task);
  Get.back(result: true);
}
