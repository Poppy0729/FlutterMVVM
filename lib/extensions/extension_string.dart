import 'package:intl/intl.dart';

extension ExtensionString on String {

  // validate string is not null or empty
  bool get isBlank => trim().isEmpty;

  String toNumberFormat({int digit = 2}) {
    return NumberFormat.currency(locale: 'th', symbol: '', decimalDigits: digit).format(double.tryParse(this) ?? 0);
  }

  bool get isEmailFormat {
    return contains(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
  }

  bool get isPasswordInputFormat {
    // Upper case, lower case, number
    return contains(RegExp(r'^[A-Za-z0-9]'));
  }

  String phoneFormat() {
    return replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "${m[1]}-${m[2]}-${m[3]}");
  }

  String get removePhoneFormatter {
    return replaceAll('-', '');
  }

  String removeKeyFormat() {
    return replaceAll("[<'", '').replaceAll("'>]", '');
  }

  String replaceKeyFormat(int startIndex, int numSpace, String replaceKey) {
    try {
      return replaceRange(0, startIndex + numSpace, replaceKey * numSpace);
    } catch (_) {
      return this;
    }
  }
}