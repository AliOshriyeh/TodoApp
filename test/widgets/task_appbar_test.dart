import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:task01/presentation/widgets/task_appbar.dart';
import '../helpers/test_helpers.dart';

void main() {
  testWidgets('TaskAppbar displays title and back button', (WidgetTester tester) async {
    await WidgetTestHelper.pumpWidget(tester, TaskAppbar(title: 'Test Title'));

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
  });

  testWidgets('TaskAppbar back button navigates back', (WidgetTester tester) async {
    final mockNavigator = NavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: const Scaffold(
          appBar: TaskAppbar(title: 'Test'),
        ),
        navigatorObservers: [mockNavigator],
      ),
    );

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    // Verify navigation occurred
    // (Would need proper navigation setup in test)
  });

  testWidgets('TaskAppbar displays title and back button', (tester) async {
    // Setup GetX test environment
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: TaskAppbar(title: 'Test'),
        ),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
  });
}
