import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task01/data/models/task_model.dart';
import 'package:task01/data/providers/sqflite_prov.dart';
import 'sqflite_prov_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late MockDatabase mockDatabase;
  late DatabaseProvider databaseProvider;

  setUp(() {
    databaseFactory = databaseFactoryFfi;
    mockDatabase = MockDatabase();
    databaseProvider = DatabaseProvider.privateConstructor();
  });

  group('Database Operations', () {
    test('insertTask returns id', () async {
      final mockDatabase = MockDatabase();
      final provider = DatabaseProvider.privateConstructor();

      // Override database instance for testing
      provider.database = Future.value(mockDatabase);

      when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);

      final task = TaskModel(id: -1, title: 'Test', desc: 'Test', crt_date: DateTime.now(), exp_date: DateTime.now(), priority: 'NORMAL', status: 'INCOMPLETE');

      final id = await provider.insertTask(task);

      expect(id, 1);
      verify(mockDatabase.insert('TaskModel', any)).called(1);
    });

    test('getTasks returns list of tasks', () async {
      final mockMaps = [
        {'id': 1, 'title': 'Task 1', 'desc': 'Desc 1', 'crt_date': DateTime.now().millisecondsSinceEpoch.toString(), 'exp_date': DateTime.now().millisecondsSinceEpoch.toString(), 'priority': 'NORMAL', 'status': 'INCOMPLETE'}
      ];

      when(mockDatabase.query(any)).thenAnswer((_) async => mockMaps);
      databaseProvider.database = Future.value(mockDatabase);

      final tasks = await databaseProvider.getTasks();
      expect(tasks.length, equals(1));
      expect(tasks[0].title, equals('Task 1'));
    });
  });
}
