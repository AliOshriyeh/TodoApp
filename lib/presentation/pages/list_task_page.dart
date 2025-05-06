import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/configs/util.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/domain/controller/theme_controller.dart';
import 'package:task01/presentation/pages/add_task_page.dart';
import 'package:task01/presentation/theme/app_assets.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/presentation/widgets/task_card.dart';

/// Main page displaying list of tasks grouped by date
class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});
  final TaskController _taskController = Get.put(TaskController());
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App bar with theme toggle and profile
          SizedBox(height: Get.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => IconButton(
                      icon: Icon(_themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
                      onPressed: _themeController.toggleTheme,
                    )),
                ClipOval(
                  child: Image.asset(AppAssets.profile, width: 50, height: 50, fit: BoxFit.cover),
                ),
              ],
            ),
          ),

          // Task list
          Expanded(
            child: Obx(() {
              if (_taskController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_taskController.filteredTasks.isEmpty) {
                return Center(
                  child: Text(
                    _taskController.searchQuery.isEmpty ? 'No tasks available' : 'No tasks found',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  ..._taskController.tasksByDate.entries.map((entry) {
                    final date = entry.key;
                    final tasks = entry.value;

                    String sectionTitle;
                    if (isSameDay(date, DateTime.now())) {
                      sectionTitle = "Today";
                    } else if (isSameDay(date, DateTime.now().add(const Duration(days: 1)))) {
                      sectionTitle = "Tomorrow";
                    } else {
                      sectionTitle = formatDate(date);
                    }

                    return _buildTaskListSection(sectionTitle, tasks);
                  }),
                ],
              );
            }),
          ),
        ],
      ),
      // Add task floating button
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(eccentricity: 0),
        backgroundColor: Get.theme.unselectedWidgetColor,
        child: Icon(Icons.add, color: Get.theme.scaffoldBackgroundColor, size: 35),
        onPressed: () async {
          await Get.to(
            () => AddTaskPage(),
            popGesture: true,
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 300),
          );
          _taskController.fetchTasks();
        },
      ),
    );
  }

  /// Builds a task list section with header
  Widget _buildTaskListSection(String title, List<TaskModel> tasks) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          if (tasks.isNotEmpty) ...[
            SizedBox(
              width: Get.width,
              height: Get.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: AppTextStyle.heavy32.copyWith(fontSize: 34)),
                  Text("Hide completed", style: AppTextStyle.medium14.copyWith(color: AppColors.info, height: 6, fontSize: 13)),
                ],
              ),
            ),
            ...tasks.map((task) => TaskCard(task: task)),
            const SizedBox(height: 16),
          ],
        ]),
      ),
    );
  }
}
