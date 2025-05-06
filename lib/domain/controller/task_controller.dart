import 'package:get/get.dart';
import 'package:task01/configs/notification_service.dart';
import 'package:task01/routes/app_routes.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/data/providers/sqflite_prov.dart';

class TaskController extends GetxController {
  DatabaseProvider databaseProvider = DatabaseProvider.instance;

  // --- Task State ---
  var tasks = <TaskModel>[].obs; // Observable list of tasks
  var isLoading = true.obs; // Loading state
  var searchQuery = ''.obs; // Search query for filtering

  @override
  void onInit() {
    super.onInit();
    checkDueTasks();
    fetchTasks(); // Load tasks on initialization
  }

  // --- Database Operations ---
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
      await task.scheduleNotification();
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
      await tasks[index].cancelNotification();
      if (tasks[index].status != 'COMPLETE') {
        await tasks[index].scheduleNotification();
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
      await NotificationService().cancelNotification(id);
      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task: $e');
    }
  }

  // --- Task Filtering & Grouping ---
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

  // Check for Due Tasks Periodically
  void checkDueTasks() {
    final now = DateTime.now();
    for (final task in tasks) {
      if (task.exp_date.isBefore(now.add(const Duration(minutes: 31))) && task.exp_date.isAfter(now) && task.status != 'COMPLETE') {
        NotificationService().scheduleTaskNotification(
          id: task.id,
          title: 'Task Due Soon: ${task.title}',
          body: 'Your task "${task.title}" is due soon',
          dueDate: task.exp_date,
        );
      }
    }
  }
}
