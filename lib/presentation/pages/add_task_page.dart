import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/configs/util.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/add_task_controller.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/presentation/widgets/custom_time_picker.dart';
import 'package:task01/presentation/widgets/task_appbar.dart';

/// Page for adding new tasks
class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});
  final controller = Get.put(AddTaskController()); // Controller for add task functionality

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskAppbar(title: "Task"),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              // Header
              Text('Add a task', style: AppTextStyle.bold32),
              const SizedBox(height: 20),

              // Task name field
              _contentFields,
              const SizedBox(height: 32),

              // Time picker
              _timePickerField,
              const SizedBox(height: 35),

              // Today toggle switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width * 0.2,
                    child: Text('Today', style: AppTextStyle.semiBold24),
                  ),
                  Obx(() => CupertinoSwitch(
                        value: controller.isToday.value,
                        onChanged: (value) => controller.toggleToday(value),
                        activeColor: AppColors.green,
                      )),
                ],
              ),
              const SizedBox(height: 30),

              // Save button
              ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.unselectedWidgetColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Save Task', style: AppTextStyle.black16.copyWith(color: Get.theme.scaffoldBackgroundColor))),
              const SizedBox(height: 20),

              // Helper text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "If you disable today, the task will be considered as tomorrow",
                  style: AppTextStyle.regular14.copyWith(color: AppColors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Saves the task to database
  Future<void> _saveTask() async {
    if (!controller.formKey.currentState!.validate()) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    final dueDateTime = DateTime(
      controller.selectedDate.value.year,
      controller.selectedDate.value.month,
      controller.selectedDate.value.day,
      controller.selectedTime.value.hour,
      controller.selectedTime.value.minute,
    );

    final newTask = TaskModel(
      id: -1, // Will be auto-incremented
      title: controller.titleController.text,
      desc: controller.descController.text,
      crt_date: DateTime.now(),
      exp_date: dueDateTime,
      priority: controller.priorityController.text,
      status: 'INCOMPLETE',
    );

    await Get.find<TaskController>().insertTask(newTask);
  }

  /// Task name input field
  Widget get _contentFields => Row(
        children: [
          SizedBox(
            width: Get.width * 0.2,
            child: Text('Name', style: AppTextStyle.semiBold24),
          ),
          Expanded(
            child: TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Lorem ipsum dolor',
                labelStyle: AppTextStyle.medium16.copyWith(color: AppColors.textGray),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textGray),
                ),
              ),
              validator: requiredFieldValidator,
            ),
          ),
        ],
      );

  /// Custom time picker widget
  Widget get _timePickerField => Row(
        children: [
          SizedBox(
            width: Get.width * 0.2,
            child: Text('Hour', style: AppTextStyle.semiBold24),
          ),
          Expanded(
            child: Obx(() {
              final time = controller.selectedTime.value;
              final isAm = time.period == DayPeriod.am;
              final hour = time.hourOfPeriod;
              final minute = time.minute;

              return Row(
                children: [
                  // Hours and minutes picker
                  Container(
                    height: 40,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(color: AppColors.cupertinoGray, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        // Hours picker
                        Expanded(
                          child: CustomTimePicker(
                            itemCount: 12,
                            initialItem: hour - 1,
                            itemExtent: 40,
                            onChanged: (index) {
                              final newHour = isAm ? index + 1 : (index + 1) + 12;
                              controller.selectedTime.value = TimeOfDay(hour: newHour % 24, minute: minute);
                            },
                            itemBuilder: (index) => Center(child: Text('${index + 1}', style: const TextStyle(fontFamily: "SFProDisplay", fontSize: 28))),
                          ),
                        ),
                        Text(':', style: AppTextStyle.black24),
                        // Minutes picker
                        Expanded(
                          child: CustomTimePicker(
                            itemCount: 60,
                            initialItem: minute,
                            itemExtent: 40,
                            onChanged: (index) => controller.selectedTime.value = TimeOfDay(hour: time.hour, minute: index),
                            itemBuilder: (index) => Center(child: Text(index.toString().padLeft(2, '0'), style: const TextStyle(fontFamily: "SFProDisplay", fontSize: 28))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // AM/PM picker
                  Container(
                    height: 38,
                    width: Get.width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: CustomTimePicker(
                      itemCount: 2,
                      initialItem: isAm ? 0 : 1,
                      itemExtent: 40,
                      onChanged: (index) {
                        final newIsAm = index == 0;
                        final newHour = newIsAm ? hour : hour + 12;
                        controller.selectedTime.value = TimeOfDay(hour: newHour % 24, minute: minute);
                      },
                      itemBuilder: (index) => Center(child: Text(index == 0 ? 'AM' : 'PM', style: AppTextStyle.medium18)),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      );
}
