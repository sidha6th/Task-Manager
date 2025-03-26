import 'package:intl/intl.dart';
import 'package:task_manager/core/global/enums/date_formates.dart';

extension DateTimeExtension on DateTime {
  String format(
    DateFormates? newPattern, {
    bool upperCased = false,
    String? locale,
  }) {
    final formattedDate = DateFormat(newPattern?.name, locale).format(this);
    if (upperCased) return formattedDate.toUpperCase();
    return formattedDate;
  }

  int get getDaysInMonth {
    return copyWith(month: month + 1, day: 0).day;
  }

  DateTime get dateOnly {
    return DateTime(year, month, day);
  }
}
