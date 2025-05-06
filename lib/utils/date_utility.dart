import 'package:intl/intl.dart';

class DateUtility {
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String getDateStrWithFormat(String format, DateTime dateTime) {
    String formattedDate = DateFormat(format).format(dateTime);
    return formattedDate;
  }
}