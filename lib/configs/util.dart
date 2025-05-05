String to12HourFormat(DateTime time) {
  int hour = time.hour;
  String period = hour < 12 ? 'AM' : 'PM';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12 AM
  return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
}

// Add this to your util.dart file or create a new helper file
String formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(DateTime(now.year, now.month, now.day)).inDays;

  if (difference == 0) return "Today";
  if (difference == 1) return "Tomorrow";
  if (difference == -1) return "Yesterday";

  // Format as "Weekday, Month Day" (e.g., "Monday, June 5")
  return "${_getWeekday(date.weekday)}, ${_getMonth(date.month)} ${date.day}";
}

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

bool isSameDay(DateTime date1, DateTime date2) {
  return (date1.year == date2.year) && (date1.month == date2.month) && (date1.day == date2.day);
}

String? requiredFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill this field";
  }
  return null;
}
