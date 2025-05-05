// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/task_controller.dart';

class EditTaskPage extends StatelessWidget {
  final TaskModel task;

  EditTaskPage({super.key, required this.task});

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priorityController = TextEditingController();
  final selectedDate = Rx<DateTime>(DateTime.now());
  final formKey = GlobalKey<FormState>();
  final taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with task data
    titleController.text = task.title;
    descController.text = task.desc;
    priorityController.text = task.priority;
    selectedDate.value = task.exp_date;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: titleController,
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
                  controller: descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: priorityController.text,
                  borderRadius: BorderRadius.circular(20),
                  items: ['HIGH', 'NORMAL', 'LOW']
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) {
                    priorityController.text = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Due Date'),
                  subtitle: Text('${selectedDate.value.toLocal()}'.split(' ')[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate.value,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate.value) {
                      selectedDate.value = picked;
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: task.status,
                  borderRadius: BorderRadius.circular(20),
                  items: ['INCOMPLETE', 'COMPLETE']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    task.status = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _updateTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Update Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateTask() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    final updatedTask = TaskModel(
      id: task.id,
      title: titleController.text,
      desc: descController.text,
      crt_date: task.crt_date,
      exp_date: selectedDate.value,
      priority: priorityController.text,
      status: task.status,
    );

    await taskController.updateTask(updatedTask);
  }
}
