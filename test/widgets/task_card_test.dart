import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/presentation/widgets/task_card.dart';
import '../helpers/test_helpers.dart';

void main() {
  late TaskController taskController;

  setUp(() {
    taskController = TaskController();
    Get.put(taskController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TaskCard displays task info', (WidgetTester tester) async {
    final task = TaskModel(id: 1, title: 'Test Task', desc: 'Test Desc', crt_date: DateTime.now(), exp_date: DateTime.now(), priority: 'NORMAL', status: 'INCOMPLETE');

    await WidgetTestHelper.pumpWidget(tester, TaskCard(task: task));

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('TaskCard shows completed style', (WidgetTester tester) async {
    final task = TaskModel(id: 1, title: 'Completed', desc: 'Done', crt_date: DateTime.now(), exp_date: DateTime.now(), priority: 'NORMAL', status: 'COMPLETE');

    await WidgetTestHelper.pumpWidget(tester, TaskCard(task: task));

    final title = tester.widget<Text>(find.text('Completed'));
    expect(title.style?.decoration, equals(TextDecoration.lineThrough));
  });

  testWidgets('TaskCard displays task info', (tester) async {
    // Setup GetX test environment
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    final task = TaskModel(id: 1, title: 'Test Task', desc: 'Test Desc', crt_date: DateTime.now(), exp_date: DateTime.now(), priority: 'NORMAL', status: 'INCOMPLETE');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskCard(task: task),
        ),
      ),
    );

    expect(find.text('Test Task'), findsOneWidget);
  });
}
