// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/configs/util.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/presentation/pages/add_task_page.dart';
import 'package:task01/presentation/theme/app_assets.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/presentation/widgets/task_card.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});

  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipOval(
                child: Image.asset(AppAssets.profile, width: 50, height: 50, fit: BoxFit.cover),
              ),
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.refresh),
          //   onPressed: _taskController.fetchTasks,
          // ),

          Expanded(
            child: Obx(() {
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     decoration: const InputDecoration(
              //       labelText: 'Search',
              //       prefixIcon: Icon(Icons.search),
              //       border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              //     ),
              //     onChanged: _taskController.filterTasks,
              //   ),
              // ),
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
                      sectionTitle = formatDate(date); // You'll need to implement formatDate()
                    }

                    return _buildTaskListSection(sectionTitle, tasks);
                  }),
                ],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(eccentricity: 0),
        backgroundColor: AppColors.black,
        child: const Icon(Icons.add, color: AppColors.white, size: 35),
        onPressed: () async {
          await Get.to(() => AddTaskPage());
          _taskController.fetchTasks();
        },
      ),
    );
  }

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
