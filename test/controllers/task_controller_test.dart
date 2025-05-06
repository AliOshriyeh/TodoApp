import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/domain/controller/task_controller.dart';
import 'package:task01/data/providers/sqflite_prov.dart';

// Generate mocks with: flutter pub run build_runner build
@GenerateMocks([DatabaseProvider])
import 'task_controller_test.mocks.dart';

void main() {
  late MockDatabaseProvider mockDatabaseProvider;
  late TaskController taskController;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockDatabaseProvider = MockDatabaseProvider();
    taskController = TaskController();

    // Inject mock provider (requires making databaseProvider settable)
    taskController.databaseProvider = mockDatabaseProvider;
  });

  group('TaskController Tests', () {
    test('fetchTasks loads tasks successfully', () async {
      final testTasks = [TaskModel(id: 1, title: 'Test Task', desc: 'Test Description', crt_date: DateTime.now(), exp_date: DateTime.now(), priority: 'NORMAL', status: 'INCOMPLETE')];

      when(mockDatabaseProvider.getTasks()).thenAnswer((_) async => testTasks);

      await taskController.fetchTasks();

      expect(taskController.tasks.length, 1);
      expect(taskController.tasks[0].title, 'Test Task');
      expect(taskController.isLoading.value, false);
    });
    test('insertTask adds new task', () async {
      // Arrange
      final newTask = TaskModel(id: -1, title: 'New Task', desc: 'New Description', crt_date: DateTime.now(), exp_date: DateTime.now(), priority: 'NORMAL', status: 'INCOMPLETE');

      when(mockDatabaseProvider.insertTask(any)).thenAnswer((_) async => 1);

      // Act
      await taskController.insertTask(newTask);

      // Assert
      verify(mockDatabaseProvider.insertTask(any)).called(1);
      expect(taskController.tasks.length, 1);
    });

    test('updateTask modifies existing task', () async {
      // Arrange
      final existingTask = TaskModel(id: 1, title: 'Old Title', desc: 'Old Desc', crt_date: DateTime.now(), exp_date: DateTime.now(), priority: 'NORMAL', status: 'INCOMPLETE');

      final updatedTask = existingTask.copyWith(title: 'New Title');

      taskController.tasks.add(existingTask);
      when(mockDatabaseProvider.updateTask(any)).thenAnswer((_) async => 1);

      // Act
      await taskController.updateTask(updatedTask);

      // Assert
      verify(mockDatabaseProvider.updateTask(any)).called(1);
      expect(taskController.tasks[0].title, 'New Title');
    });
  });
}
