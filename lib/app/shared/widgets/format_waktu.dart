import 'package:intl/intl.dart';

String FormatToUsableDate(String date) {
  return '${DateFormat(DateFormat.HOUR24_MINUTE).format(DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date, true).toLocal())} - ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date, true).toLocal())}';
}

String FormatToLocalTime(String date) {
  return DateFormat(
    DateFormat.HOUR24_MINUTE,
  ).format(DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date, true).toLocal());
}

String FormatToLocalDate(String date) {
  return DateFormat(
    DateFormat.YEAR_MONTH_DAY,
  ).format(DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date, true).toLocal());
}

int GetMillisecondSinceEpoch(String date) {
  return DateFormat(
    "yyyy-MM-ddTHH:mm:ssZ",
  ).parse(date, true).toLocal().millisecondsSinceEpoch;
}

DateTime MakeLocalDateTime(String date) {
  return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date, true).toLocal();
}
