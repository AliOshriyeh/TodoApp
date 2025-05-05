import 'package:get/get.dart';
import 'package:task01/routes/app_routes.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/data/providers/sqflite_prov.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading(true);
      final tasksList = await DatabaseProvider.instance.getTasks();
      tasks.assignAll(tasksList);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tasks: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> insertTask(TaskModel task) async {
    try {
      isLoading(true);
      int id = await DatabaseProvider.instance.insertTask(task);
      task.id = id; // Update the task with the new ID
      tasks.add(task);
      Get.snackbar('Success', 'Task added');
      Get.offAllNamed(AppRoutes.tasklist);
    } catch (e) {
      (error) => Get.snackbar('Error', error);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    try {
      isLoading(true);
      await DatabaseProvider.instance.updateTask(updatedTask);
      final index = tasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        tasks[index] = updatedTask;
      }
      Get.snackbar('Success', 'Task updated successfully');
      Get.offAllNamed(AppRoutes.tasklist);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateTaskStatus(TaskModel task) async {
    final updatedTask = task.copyWith(status: task.status == 'COMPLETE' ? 'INCOMPLETE' : 'COMPLETE');
    try {
      await DatabaseProvider.instance.updateTask(updatedTask);
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = updatedTask;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task status');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await DatabaseProvider.instance.deleteTask(id);
      tasks.removeWhere((task) => task.id == id);
      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task: $e');
    }
  }

  void filterTasks(String query) {
    searchQuery.value = query.toLowerCase();
  }

  List<TaskModel> get filteredTasks {
    if (searchQuery.isEmpty) return tasks;
    return tasks.where((task) => task.title.toLowerCase().contains(searchQuery.value.toLowerCase()) || task.desc.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
  }

  Map<DateTime, List<TaskModel>> get tasksByDate {
    final Map<DateTime, List<TaskModel>> groupedTasks = {};

    for (final task in filteredTasks) {
      // Normalize the date (remove time part)
      final taskDate = DateTime(
        task.exp_date.year,
        task.exp_date.month,
        task.exp_date.day,
      );

      if (!groupedTasks.containsKey(taskDate)) {
        groupedTasks[taskDate] = [];
      }
      groupedTasks[taskDate]!.add(task);
    }

    // Sort the dates in ascending order
    final sortedDates = groupedTasks.keys.toList()..sort((a, b) => a.compareTo(b));

    // Create a new sorted map
    final sortedMap = <DateTime, List<TaskModel>>{};
    for (final date in sortedDates) {
      sortedMap[date] = groupedTasks[date]!;
    }

    return sortedMap;
  }
}
