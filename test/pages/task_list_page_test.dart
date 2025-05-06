import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/domain/controller/theme_controller.dart';
import 'package:task01/presentation/pages/list_task_page.dart';
import 'package:task01/presentation/widgets/task_card.dart';
import '../helpers/test_helpers.dart';

void main() {
  late TaskController taskController;
  late ThemeController themeController;

  setUp(() {
    taskController = TaskController();
    themeController = ThemeController();
    Get.put(taskController);
    Get.put(themeController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TaskListPage shows loading indicator', (WidgetTester tester) async {
    taskController.isLoading.value = true;

    await WidgetTestHelper.pumpWidget(tester, TaskListPage());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('TaskListPage shows tasks grouped by date', (WidgetTester tester) async {
    final now = DateTime.now();
    taskController.tasks.assignAll([
      TaskModel(id: 1, title: 'Today', desc: 'Today', crt_date: now, exp_date: now, priority: 'NORMAL', status: 'INCOMPLETE'),
      TaskModel(id: 2, title: 'Tomorrow', desc: 'Tomorrow', crt_date: now, exp_date: now.add(Duration(days: 1)), priority: 'NORMAL', status: 'INCOMPLETE'),
    ]);
    taskController.isLoading.value = false;

    await WidgetTestHelper.pumpWidget(tester, TaskListPage());

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Tomorrow'), findsOneWidget);
    expect(find.byType(TaskCard), findsNWidgets(2));
  });

  testWidgets('TaskListPage shows loading indicator', (tester) async {
    // Setup GetX test environment
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    final taskController = TaskController();
    taskController.isLoading.value = true;
    Get.put(taskController);
    Get.put(ThemeController());

    await tester.pumpWidget(
      MaterialApp(
        home: TaskListPage(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
