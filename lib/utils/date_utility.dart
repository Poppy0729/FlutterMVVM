import 'package:intl/intl.dart';

class DateUtility {
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String formatTime(int dateTime, {String format = 'MMM dd, HH:mm'}) {
    String date = DateFormat(format, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(dateTime * 1000)).toString();
    return date;
  }

  String getDateStrWithFormat(String format, DateTime dateTime) {
    String formattedDate = DateFormat(format).format(dateTime);
    return formattedDate;
  }
}