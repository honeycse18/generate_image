import 'package:image_api_project/api_response/image_response/api_helper/api_helper.dart';
import 'package:intl/intl.dart';

extension APIDateTime on DateTime {
  String formatted(String dateTimeFormat, {String? locale}) {
    try {
      return DateFormat(dateTimeFormat, locale).format(this);
    } catch (e) {
      return '';
    }
  }

  String toStringForAPI({
    String dateTimeFormat = '',
    bool toUTCTime = true,
  }) =>
      APIHelper.getStringFromDateTime(this,
          dateTimeFormat: dateTimeFormat, toUTCTime: toUTCTime);
}
