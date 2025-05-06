import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/edit_task_controller.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/presentation/widgets/task_appbar.dart';

/// Page for editing existing tasks
class EditTaskPage extends StatelessWidget {
  final TaskModel task;
  const EditTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditTaskController>();
    controller.initializeWithTask(task); // Initialize with existing task data

    return Scaffold(
      appBar: const TaskAppbar(title: "Edit Task"),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                // Title field
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 12),

                // Description field
                TextFormField(
                  maxLines: 3,
                  controller: controller.descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 16),

                // Priority dropdown
                DropdownButtonFormField<String>(
                  value: controller.priorityController.text,
                  borderRadius: BorderRadius.circular(20),
                  items: ['HIGH', 'NORMAL', 'LOW']
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) => controller.priorityController.text = value!,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 16),

                // Date picker
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

                // Status dropdown
                DropdownButtonFormField<String>(
                  value: controller.status.value,
                  borderRadius: BorderRadius.circular(20),
                  items: ['INCOMPLETE', 'COMPLETE']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) => controller.status.value = value!,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 32),

                // Update button
                ElevatedButton(
                  onPressed: () => _updateTask(controller, task),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.unselectedWidgetColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Update Task', style: AppTextStyle.black16.copyWith(color: Get.theme.scaffoldBackgroundColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Updates the task in database
Future<void> _updateTask(EditTaskController controller, TaskModel task) async {
  await controller.updateTask(task);
  Get.back(result: true);
}
