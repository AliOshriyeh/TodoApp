import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task01/configs/util.dart';

void main() {
  group('Date and Time Utilities', () {
    test('to12HourFormat converts 24-hour to 12-hour format', () {
      expect(to12HourFormat(DateTime(2023, 1, 1, 14, 30)), equals('2:30 PM'));
      expect(to12HourFormat(DateTime(2023, 1, 1, 8, 5)), equals('8:05 AM'));
      expect(to12HourFormat(DateTime(2023, 1, 1, 0, 0)), equals('12:00 AM'));
    });

    test('formatDate shows relative dates correctly', () {
      final now = DateTime.now();
      expect(formatDate(now), equals('Today'));
      expect(formatDate(now.add(const Duration(days: 1))), equals('Tomorrow'));
      expect(formatDate(now.subtract(const Duration(days: 1))), equals('Yesterday'));
      expect(formatDate(DateTime(2023, 6, 15)), equals('Thu, Jun 15'));
    });

    test('formatTime formats TimeOfDay correctly', () {
      expect(formatTime(const TimeOfDay(hour: 14, minute: 30)), equals('2:30 PM'));
      expect(formatTime(const TimeOfDay(hour: 8, minute: 5)), equals('8:05 AM'));
    });

    test('isSameDay compares dates correctly', () {
      final date1 = DateTime(2023, 6, 15, 10, 30);
      final date2 = DateTime(2023, 6, 15, 23, 59);
      final date3 = DateTime(2023, 6, 16, 0, 0);

      expect(isSameDay(date1, date2), isTrue);
      expect(isSameDay(date1, date3), isFalse);
    });
  });

  group('Validation Utilities', () {
    test('requiredFieldValidator validates empty fields', () {
      expect(requiredFieldValidator(null), equals('Please fill this field'));
      expect(requiredFieldValidator(''), equals('Please fill this field'));
      expect(requiredFieldValidator('some value'), isNull);
    });
  });
}
