import 'package:intl/src/intl/date_format.dart';

class AppConstant {
  static const String defaultCurrencyFormat = '#,##0.00 \u00A4';
  static final apiDateTimeFormat =
      DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
  static const int unsetDateTimeYear = 1800;
  static final DateTime unsetDateTime = DateTime(unsetDateTimeYear);
}
