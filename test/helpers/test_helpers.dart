import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Generate mocks with: flutter pub run build_runner build
@GenerateMocks([Database, SupabaseClient])
void main() {}

// Base class for widget tests
class WidgetTestHelper {
  static Future<void> pumpWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
    await tester.pumpAndSettle();
  }
}
