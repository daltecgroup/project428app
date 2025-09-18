import 'package:intl/intl.dart';

DateTime get tenYearsAgo {
  return DateTime.now().subtract(const Duration(days: 365 * 10));
}

String get idTimeZone {
  switch (DateTime.now().timeZoneOffset.inHours) {
    case 7:
      return 'WIB';
    case 8:
      return 'WITA';
    case 9:
      return 'WIT';
    default:
      return 'UTC';
  }
}

bool isToday(DateTime inputDate) {
  bool result = false;
  DateTime now = DateTime.now();
  if (inputDate.year == now.year &&
      inputDate.month == now.month &&
      inputDate.day == now.day) {
    result = true;
  }
  return result;
}

String localDateTimeFormat(DateTime inputDate) {
  DateTime date = inputDate.toUtc();
  String dateString = DateFormat(
    DateFormat.YEAR_MONTH_DAY,
    'id',
  ).format(date.toLocal());

  return "$dateString, ${DateFormat(DateFormat.HOUR24_MINUTE, 'id').format(date.toLocal())} $idTimeZone";
}

String localDateFormat(DateTime inputDate) {
  DateTime date = inputDate.toUtc();
  String dateString = DateFormat(
    DateFormat.YEAR_MONTH_DAY,
    'id',
  ).format(date.toLocal());

  return dateString;
}

String localDayDateFormat(DateTime inputDate) {
  DateTime date = inputDate.toUtc();
  String dateString = DateFormat(
    DateFormat.YEAR_MONTH_WEEKDAY_DAY,
    'id',
  ).format(date.toLocal());

  return dateString;
}

String localMonthYearFormat(DateTime inputDate) {
  DateTime date = inputDate.toUtc();
  String dateString = DateFormat(
    DateFormat.YEAR_MONTH,
    'id',
  ).format(date.toLocal());

  return dateString;
}

String contextualLocalDateTimeFormat(DateTime inputDate) {
  DateTime date = inputDate.toUtc();
  String dateString = DateFormat(
    DateFormat.YEAR_MONTH_DAY,
    'id',
  ).format(date.toLocal());

  if (isToday(inputDate)) dateString = 'hari ini';

  return "$dateString, pukul ${DateFormat(DateFormat.HOUR24_MINUTE, 'id').format(date.toLocal())} $idTimeZone";
}

String contextualLocalDateFormat(DateTime inputDate) {
  DateTime now = DateTime.now();
  DateTime yesterday = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(const Duration(days: 1));
  DateTime input = DateTime(inputDate.year, inputDate.month, inputDate.day);

  if (isToday(inputDate)) {
    return 'hari ini';
  } else if (input == yesterday) {
    return 'kemarin';
  } else {
    return localDateFormat(inputDate);
  }
}

String localTimeFormat(DateTime inputDate) {
  DateTime date = inputDate.toUtc();
  return "${DateFormat(DateFormat.HOUR24_MINUTE, 'id').format(date.toLocal())} $idTimeZone";
}

String get currentDateString {
  DateTime now = DateTime.now();
  return DateFormat('yyMMdd').format(now);
}

/// Calculates the number of calendar days between two DateTime objects.
int daysBetween(DateTime from, DateTime to) {
  // 1. Normalize both dates to midnight to ignore the time component.
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);

  // 2. Calculate the difference and return it in days.
  // The .inDays property gives the total number of full days.
  return to.difference(from).inDays;
}
