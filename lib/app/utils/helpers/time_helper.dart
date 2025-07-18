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
