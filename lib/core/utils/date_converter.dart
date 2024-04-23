import 'package:intl/intl.dart';

String datetimeToFormattedString(String format, DateTime date) {
  return DateFormat(format).format(date);
}

String datetimeToFrenchFormat(DateTime date) {
  return datetimeToFormattedString('dd/MM/yyyy', date);
}

DateTime formattedStringToDatetime(String format, String date) {
  return DateFormat(format).parse(date);
}

DateTime frenchFormatToDatetime(String dateFr) {
  return formattedStringToDatetime('dd/MM/yyyy', dateFr);
}

DateTime stringToDatetime(String date) {
  return DateTime.parse(date);
}
