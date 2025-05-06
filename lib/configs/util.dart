import 'package:flutter/material.dart';

/// Utility functions for date, time, and form validation

/// Converts 24-hour time to 12-hour format with AM/PM
/// Example: 14:30 → "2:30 PM"
String to12HourFormat(DateTime time) {
  int hour = time.hour;
  String period = hour < 12 ? 'AM' : 'PM';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12 AM
  return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
}

/// Formats a date with relative terms (Today/Tomorrow/Yesterday) or weekday
/// Example:
/// - Same day → "Today"
/// - Next day → "Tomorrow"
/// - Previous day → "Yesterday"
/// - Other dates → "Mon, Jun 5"
String formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(DateTime(now.year, now.month, now.day)).inDays;

  if (difference == 0) return "Today";
  if (difference == 1) return "Tomorrow";
  if (difference == -1) return "Yesterday";

  // Format as "Weekday, Month Day" (e.g., "Mon, Jun 5")
  return "${_getWeekday(date.weekday)}, ${_getMonth(date.month)} ${date.day}";
}

/// Formats TimeOfDay to 12-hour format string
/// Example: TimeOfDay(hour: 14, minute: 30) → "2:30 PM"
String formatTime(TimeOfDay time) {
  final hour = time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

/// Returns abbreviated weekday name from weekday number (1-7)
String _getWeekday(int weekday) {
  switch (weekday) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '';
  }
}

/// Returns abbreviated month name from month number (1-12)
String _getMonth(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}

/// Checks if two DateTime objects represent the same calendar day
/// Ignores time components, only compares year, month, and day
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}

/// Validates that a form field is not empty
/// Returns error message if empty, null if valid
String? requiredFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill this field";
  }
  return null;
}
