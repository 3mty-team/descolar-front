import 'package:intl/intl.dart';

String datetimeToFormattedString(String format, DateTime date) {
  return DateFormat(format).format(date);
}

String postDateToFrenchFormat(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat dateFormat = DateFormat('dd MMM. yyyy');
  return dateFormat.format(dateTime);
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
