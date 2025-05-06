import 'package:flutter_test/flutter_test.dart';
import 'package:task01/data/models/task_model.dart';

void main() {
  final testTask = TaskModel(
    id: 1,
    title: 'Test Task',
    desc: 'Test Description',
    crt_date: DateTime(2023, 6, 1),
    exp_date: DateTime(2023, 6, 15),
    priority: 'NORMAL',
    status: 'INCOMPLETE',
  );

  group('TaskModel', () {
    test('props contains all properties', () {
      expect(testTask.props, equals([1, 'Test Task', 'Test Description', DateTime(2023, 6, 1), DateTime(2023, 6, 15), 'NORMAL', 'INCOMPLETE']));
    });

    test('copyWith creates modified copy', () {
      final copied = testTask.copyWith(title: 'New Title', status: 'COMPLETE');
      expect(copied.title, equals('New Title'));
      expect(copied.status, equals('COMPLETE'));
      expect(copied.id, equals(testTask.id)); // Unchanged
    });

    test('fromMap creates model from map', () {
      final map = {
        'id': 2,
        'title': 'Mapped Task',
        'desc': 'Mapped Desc',
        'crt_date': DateTime(2023, 1, 1).millisecondsSinceEpoch.toString(),
        'exp_date': DateTime(2023, 1, 2).millisecondsSinceEpoch.toString(),
        'priority': 'HIGH',
        'status': 'COMPLETE',
      };
      final task = TaskModel.fromMap(map);

      expect(task.id, equals(2));
      expect(task.title, equals('Mapped Task'));
      expect(task.priority, equals('HIGH'));
    });

    test('toMap converts model to map', () {
      final map = testTask.toMap();
      expect(map['title'], equals('Test Task'));
      expect(map['priority'], equals('NORMAL'));
      expect(map.containsKey('id'), isTrue);
    });
  });
}
