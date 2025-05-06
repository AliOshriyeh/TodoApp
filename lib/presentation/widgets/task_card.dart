import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/configs/util.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task01/domain/binding/edit_task_binding.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/presentation/pages/edit_task_page.dart';

import 'package:task01/presentation/theme/index_theme.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/routes/app_routes.dart';

/// Interactive task card with swipe-to-edit/delete functionality
class TaskCard extends StatelessWidget {
  final TaskModel task; // Task data to display
  TaskCard({super.key, required this.task});

  final TaskController _taskController = Get.find(); // Task controller instance

  @override
  Widget build(BuildContext context) {
    bool tstatus = task.status == 'COMPLETE';
    bool isToday = isSameDay(task.exp_date, DateTime.now());

    return Slidable(
      enabled: !tstatus, // Disable sliding for completed tasks
      key: ValueKey(task.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          // Edit action button
          SlidableAction(
            onPressed: (context) => _editTask(context),
            backgroundColor: AppColors.primaryAccent,
            foregroundColor: AppColors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          // Delete action button
          SlidableAction(
            onPressed: (context) => _deleteTask(context),
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(task.title,
            style: AppTextStyle.medium16.copyWith(
              color: tstatus ? Colors.grey.shade400 : AppColors.grey,
              decorationColor: tstatus ? AppColors.lightGray : AppColors.grey,
              decoration: tstatus ? TextDecoration.lineThrough : null,
            )),
        subtitle: Text(
          to12HourFormat(task.exp_date),
          style: AppTextStyle.medium14.copyWith(color: tstatus ? AppColors.lightGray : AppColors.brightGrey),
        ),
        leading: SizedBox(
          width: 30,
          height: 30,
          child: isToday
              ? Transform.scale(
                  scale: 1.4,
                  child: Checkbox(
                    side: const BorderSide(color: AppColors.lightGray, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    checkColor: Get.theme.scaffoldBackgroundColor,
                    fillColor: WidgetStatePropertyAll(tstatus ? Get.theme.unselectedWidgetColor : Get.theme.scaffoldBackgroundColor),
                    value: tstatus,
                    onChanged: (bool? value) async => await _taskController.updateTaskStatus(task),
                  ),
                )
              : Icon(
                  Icons.circle_rounded,
                  color: Get.theme.unselectedWidgetColor,
                  size: 16,
                ),
        ),
      ),
    );
  }

  /// Navigates to edit task page
  void _editTask(BuildContext context) async {
    Slidable.of(context)?.close();
    await Get.to(() => EditTaskPage(task: task), binding: EditTaskBinding());
    _taskController.fetchTasks();
  }

  /// Shows confirmation dialog and deletes task
  void _deleteTask(BuildContext context) {
    Slidable.of(context)?.close();
    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(20),
      title: 'Delete Task',
      content: const Text('Are you sure you want to delete this task?'),
      confirm: TextButton(
        child: const Text('Delete'),
        onPressed: () {
          _taskController.deleteTask(task.id);
          Get.offAllNamed(AppRoutes.tasklist);
        },
      ),
      cancel: TextButton(
        child: const Text('Cancel'),
        onPressed: () => Get.back(),
      ),
    );
  }
}
