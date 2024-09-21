import 'dart:io';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_api_project/api_response/image_response/api_helper/app_constant.dart';
import 'package:image_api_project/api_response/image_response/api_helper/datetime.dart';
import 'package:intl/intl.dart';

class APIHelper {
  static String getSafeString(dynamic unsafeResponseStringValue) {
    const String defaultStringValue = '';
    if (unsafeResponseStringValue == null) {
      return defaultStringValue;
    } else if (unsafeResponseStringValue is String) {
      // Now it is safe
      return unsafeResponseStringValue;
    }
    return defaultStringValue;
  }

  static List<T> getSafeList<T>(dynamic unsafeResponseListValue) {
    const List<T> defaultListValue = [];
    if (unsafeResponseListValue == null) {
      return defaultListValue;
    } else if (unsafeResponseListValue is List<T>) {
      // Now it is safe
      return unsafeResponseListValue;
    }
    return defaultListValue;
  }

  static DateTime getSafeDateTime(
    dynamic unsafeResponseDateTimeStringValue, {
    String dateTimeFormat = '',
    bool isUTCTime = true,
  }) {
    final String safeDateTimeStringValue =
        getSafeString(unsafeResponseDateTimeStringValue);
    return getSafeDateTimeFromString(safeDateTimeStringValue,
        dateTimeFormat: dateTimeFormat, isUTCTime: isUTCTime);
  }

  static int getSafeInt(dynamic unsafeResponseIntValue,
      [int defaultIntValue = 0]) {
    if (unsafeResponseIntValue == null) {
      return defaultIntValue;
    } else if (unsafeResponseIntValue is String) {
      return (num.tryParse(unsafeResponseIntValue) ?? defaultIntValue).toInt();
    } else if (unsafeResponseIntValue is num) {
      // Now it is safe
      return unsafeResponseIntValue.toInt();
    }
    return defaultIntValue;
  }

  static double getSafeDouble(dynamic unsafeResponseDoubleValue,
      [double defaultDoubleValue = 0]) {
    if (unsafeResponseDoubleValue == null) {
      return defaultDoubleValue;
    } else if (unsafeResponseDoubleValue is String) {
      return (num.tryParse(unsafeResponseDoubleValue) ?? defaultDoubleValue)
          .toDouble();
    } else if (unsafeResponseDoubleValue is num) {
      // Now it is safe
      return unsafeResponseDoubleValue.toDouble();
    }
    return defaultDoubleValue;
  }

  static bool isBool(dynamic boolAsString) {
    if (boolAsString is! String) {
      return false;
    }
    if (boolAsString == 'true') {
      return true;
    } else if (boolAsString == 'false') {
      return true;
    }
    return false;
  }

  static bool? getBoolFromString(String boolAsString) {
    if (boolAsString == 'true') {
      return true;
    } else if (boolAsString == 'false') {
      return false;
    }
    return null;
  }

  static bool getSafeBool(dynamic unsafeResponseBoolValue,
      [bool defaultBoolValue = false]) {
    if (unsafeResponseBoolValue == null) {
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is String) {
      if (isBool(unsafeResponseBoolValue)) {
        return getBoolFromString(unsafeResponseBoolValue) ?? defaultBoolValue;
      }
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is bool) {
      // Now it is safe
      return unsafeResponseBoolValue;
    }
    return defaultBoolValue;
  }

  static DateTime getSafeDateTimeFromString(
    String dateTimeAsString, {
    String dateTimeFormat = '',
    bool isUTCTime = true,
  }) {
    try {
      if (dateTimeFormat.isNotEmpty) {
        return DateFormat(dateTimeFormat)
            .parse(dateTimeAsString, isUTCTime)
            .toLocal();
      }
      return AppConstant.apiDateTimeFormat
          .parse(dateTimeAsString, isUTCTime)
          .toLocal();
    } catch (e) {
      return AppConstant.unsetDateTime;
    }
  }

  static String getStringFromDateTime(DateTime dateTime,
      {String dateTimeFormat = '', bool toUTCTime = true}) {
    final correctDateTime =
        switch (toUTCTime) { true => dateTime.toUtc(), false => dateTime };
    if (dateTimeFormat.isNotEmpty) {
      return correctDateTime.formatted(dateTimeFormat);
    }
    return AppConstant.apiDateTimeFormat.format(correctDateTime);
  }

  static bool isSafeMapObject(dynamic unsafeValue) {
    if (unsafeValue is Map<String, dynamic>) {
      // Now it is safe
      return true;
    }
    return false;
  }

  static bool isTextIsCardNumberWithDashes(String text) =>
      RegExp(r'^(\d{4}-){3}\d{4}$').hasMatch(text);

  static bool isTextIsCardNumberWithSpaces(String text) =>
      RegExp(r'^(\d{4} ){3}\d{4}$').hasMatch(text);

  static bool isTextIsCardNumberWithNoDelimiter(String text) =>
      RegExp(r'^\d{16}$').hasMatch(text);

  static bool isTextIsBarcodeNumber(String text) =>
      RegExp(r'^\d{8}$').hasMatch(text);

  static bool isTextIsCardNumber(String text) =>
      isTextIsCardNumberWithDashes(text) ||
      isTextIsCardNumberWithSpaces(text) ||
      isTextIsCardNumberWithNoDelimiter(text);

  static String removeCardDelimiterCharacters(String cardNumber) {
    String card = cardNumber;
    card = card.trim();
    card = card.replaceAll(' ', '');
    card = card.replaceAll('-', '');
    return card;
  }

  static bool isAPIResponseObjectSafe<T>(Object? unsafeValue) {
    if (unsafeValue is Map<String, dynamic>) {
      // Now it is safe
      return true;
    }
    return false;
  }
}
