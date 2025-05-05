import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:task01/configs/util.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/binding/edit_task_binding.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/presentation/pages/edit_task_page.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/routes/app_routes.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  TaskCard({super.key, required this.task});

  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool tstatus = task.status == 'COMPLETE';
    bool isToday = isSameDay(task.exp_date, DateTime.now());

    return Slidable(
      // Only allow sliding if the task is not completed
      enabled: !tstatus,
      key: ValueKey(task.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          // Edit button
          SlidableAction(
            onPressed: (context) => _editTask(context),
            backgroundColor: AppColors.primaryAccent,
            foregroundColor: AppColors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          // Delete button
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
                    checkColor: AppColors.white,
                    fillColor: WidgetStatePropertyAll(tstatus ? AppColors.black : AppColors.white),
                    value: tstatus,
                    onChanged: (bool? value) async => await _taskController.updateTaskStatus(task),
                  ),
                )
              : const Icon(
                  Icons.circle_rounded,
                  color: AppColors.black,
                  size: 16,
                ),
        ),
      ),
    );
  }

  void _editTask(BuildContext context) async {
    Slidable.of(context)?.close();
    // Navigate to edit page
    await Get.to(() => EditTaskPage(task: task), binding: EditTaskBinding());
    _taskController.fetchTasks();
  }

  void _deleteTask(BuildContext context) {
    Slidable.of(context)?.close();
    // Show confirmation dialog
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

Color _getPriorityColor(String priority) {
  switch (priority) {
    case 'HIGH':
      return Colors.red;
    case 'NORMAL':
      return Colors.blue;
    case 'LOW':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

//   subtitle: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(task.desc),
//       const SizedBox(height: 4),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//             decoration: BoxDecoration(
//               color: _getPriorityColor(task.priority),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(
//               task.priority,
//               style: const TextStyle(color: Colors.white, fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
