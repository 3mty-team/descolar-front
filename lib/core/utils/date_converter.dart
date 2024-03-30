import 'package:intl/intl.dart';

String datetimeToFrenchFormat(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
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
