import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

import 'local_helper.dart';

class DateTimeUtil {
  static const String dateFormat = "EEEE, dd MMMM yyyy";
  static const String dateTimeFormat = "dd MMMM, hh:mm aa";

  static String formatDate(
    DateTime date, {
    String newFormat = dateFormat,
  }) {
    String selectedDate = DateFormat(
      newFormat,
      LocaleHelper.getCurrentLocale(),
    ).format(date);
    return selectedDate;
  }

  static String formatStringDate(
    String date, {
    String oldFormat = "MM/dd/yyyy",
    String newFormat = dateFormat,
  }) {
    try {
      DateTime dateTime = DateFormat(oldFormat, "en").parse(date);
      String selectedDate = DateFormat(
        newFormat,
        LocaleHelper.getCurrentLocale(),
      ).format(dateTime);
      return selectedDate;
    } catch (_) {}
    return date;
  }

  static String formatStringTime(
    String time, {
    String oldFormat = "hh:mm aa",
    String newFormat = "hh:mm aa",
  }) {
    try {
      DateTime dateTime = DateFormat(oldFormat, "en").parse(time);
      String selectedTime = DateFormat(
        newFormat,
        LocaleHelper.getCurrentLocale(),
      ).format(dateTime);
      return selectedTime;
    } catch (_) {}
    return time;
  }

  static DateTime getDateFromString(
    String date, {
    String oldFormat = "MM/dd/yyyy",
  }) {
    return DateFormat(oldFormat, "en").parse(date);
  }
}

extension DateTimeExtension on DateTime {
  DateTime getDateOnly() =>
      DateFormat.yMd().parse(DateFormat.yMd().format(this));
}
