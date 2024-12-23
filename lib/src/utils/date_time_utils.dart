import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../localization/app_localization_manager.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static final _formatBirthDate = DateFormat('dd/MM/yyyy');
  static final _formatBirthDateForServer = DateFormat('yyyy-MM-dd');
  static final _formatGratitudeDate = DateFormat('yyyy-MM-dd');
  static final _formatWorkingHoursDate = DateFormat('yyyy-MM-dd');
  static final _formatOverviewBirthDate = DateFormat('dd, MMM yyyy');
  static final _formatPackageExpiryDate = DateFormat('yyyy MMM dd');
  static final _formatDateTime = DateFormat('yyyy-MM-dd hh:mm:ss');
  static final _formatDisplayD_formatBirthDateForServerate =
      DateFormat('MMM dd, yyyy');
  static final _formatMonthYear = DateFormat('MMM yyyy');
  static final _formatDay = DateFormat('dd');
  static final _formathour = DateFormat('HH');
  static final _formatTime = DateFormat('HH:mm');
  static final _formatTime1 = DateFormat('HH:mm:ss');

  static final _format12Time = DateFormat('hh:mm a');
  static final _formatDayName = DateFormat('EEE');
  static final _formatDayFullName = DateFormat('EEEE');
  static final _formatDayMonth = DateFormat('dd MMM');
  static final _formatDayMonthYear = DateFormat('dd MMM yyyy');
  static final _formatDayNameYear = DateFormat('dd EEE , yyyy');
  static final _formatDateWithName = DateFormat('EEEE, dd MMMM, yyyy');
  static final _formatDateWithMonthName = DateFormat('dd MMM, yyyy');
  static final _formatDateApi = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  static final _formatDateApi1 = DateFormat("yyyy-MM-dd HH:mm:ss");

  static getApiStringDate(DateTime? date) {
    if (date == null) return '';
    return _formatDateApi.format(date);
  }

  static String? getActivityTime(String? date) {
    if (date == null) return null;
    DateTime mm = _formatTime1.parse(date);
    return _format12Time.format(mm).toLowerCase();
  }

  static DateTime getGratitudeData(DateTime date) {
    String s = _formatGratitudeDate.format(date);
    return _formatGratitudeDate.parse(s);
  }

  static getApiStringLogTime(DateTime? date) {
    if (date == null) return '';
    return _format12Time.format(date);
  }

  static getApiStringMonthNameDate(DateTime? date) {
    if (date == null) return '';
    return _formatDateWithMonthName.format(date);
  }

  static getDatemonth(DateTime? date) {
    if (date == null) return '';
    return _formatOverviewBirthDate.format(date);
  }

  static getApiStringDateToUtc(DateTime? date) {
    if (date == null) return '';
    return _formatDateApi.format(date.toUtc());
  }

  static getExpiryPackageFormat(DateTime? date) {
    if (date == null) return '';
    return _formatPackageExpiryDate.format(date);
  }

  static DateTime? getApiDatetoUtc(String? date) {
    if (date == null) return null;
    return _formatDateApi.parse(date);
  }

  static DateTime? getApiDate111(String? date) {
    if (date == null) return null;
    return _formatDateApi.parse(date);
  }

  static DateTime? getEventDateFormat(String? date) {
    if (date == null) return null;
    return _formatBirthDateForServer.parse(date);
  }

  static DateTime? getApiDate(String? date) {
    if (date == null) return null;
    return Intl.withLocale('en', () => _formatDateApi.parse(date));
  }

  static DateTime mostRecentWeekday(DateTime date, int weekday) =>
      DateTime(date.year, date.month, date.day - (date.weekday - weekday) % 7);
  static DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
  static DateTime? getApiDateUtc(String? date) {
    if (date == null) return null;
    return _formatDateApi.parse(date, true).toLocal() /*.toUtc()*/;
    return Intl.withLocale('en', () => _formatDateApi.parse(date).toUtc());
  }

  static getWorkingHourDate1(DateTime? date) {
    if (date == null) return '';
    return _formatDateApi1.format(date);
  }

  static DateTime? getApiDate11(String? date) {
    if (date == null) return null;
    return _formatDateApi1.parse(date);
  }

  static getHour(DateTime? date) {
    if (date == null) return '';
    return _formathour.format(date);
  }

  static monthYearDate(DateTime? date) {
    if (date == null) return '';
    return _formatMonthYear.format(date);
  }

  static showweekRangeDate(DateTime? startDate, DateTime? endDate) {
    if (startDate == null && endDate == null) return '';
    return "${_formatDayMonth.format(startDate!)} - ${_formatDayMonthYear.format(endDate!)}";
  }

  static getDayMonthYear(DateTime? date) {
    if (date == null) return '';
    return _formatDayMonthYear.format(date);
  }

  static getDayMonth(DateTime? date) {
    if (date == null) return '';
    return _formatDayMonth.format(date);
  }

  static String? getDOBDateFormat(String? date) {
    if (date == null) return null;
    return _formatBirthDate.format(_formatBirthDateForServer.parse(date));
  }

  static getOnlyTime(DateTime? startDate) {
    if (startDate == null) return '';
    return _formatTime.format(startDate);
  }

  static getOnlyDate(DateTime? startDate) {
    if (startDate == null) return '';
    return _formatDayNameYear.format(startDate);
  }

  static getDay(DateTime? date) {
    if (date == null) return '';
    return _formatDay.format(date);
  }

  static getDayFullName(DateTime? date) {
    if (date == null) return '';
    return _formatDayFullName.format(date);
  }

  static getformatDateWithName(DateTime? date) {
    if (date == null) return '';
    return _formatDateWithName.format(date);
  }

  static getDayName(DateTime? date) {
    if (date == null) return '';
    return _formatDayName.format(date);
  }

  static String formatBirthDate(DateTime? date) {
    if (date == null) return '';
    return _formatBirthDate.format(date);
  }

  static String formatBirthDateForServer(DateTime? date) {
    if (date == null) return '';
    return Intl.withLocale('en', () => _formatBirthDateForServer.format(date));
  }

  static DateTime? parseBirthDateFromServer(String? dateOfBirth) {
    if (dateOfBirth == null) return null;
    return Intl.withLocale('en', () => _formatBirthDate.parse(dateOfBirth));
  }

  static String formatBirthDateFromServer(String? dateOfBirth) {
    if (dateOfBirth == null) return '';
    final dateTime =
        Intl.withLocale('en', () => _formatBirthDate.parse(dateOfBirth));
    return _formatOverviewBirthDate.format(dateTime);
  }

  static String? formatBirthDateUserToServer(String? dateOfBirth) {
    if (dateOfBirth == null) return null;
    final dateTime =
        Intl.withLocale('en', () => _formatBirthDate.parse(dateOfBirth));
    return _formatBirthDateForServer.format(dateTime);
  }

  static String timeAgoSinceDateApi(String? dateTimeString) {
    if (dateTimeString == null) return '';
    final inputDate = _formatDateApi.parse(dateTimeString, true).toLocal();

    //return timeago.format(inputDate, allowFromNow: true, locale: AppLocalizationManager.isCurrentEnglish ? 'en':'ar');
    final currentDateTime = DateTime.now();
    final difference = currentDateTime.difference(inputDate);
    print(inputDate);
    print(currentDateTime);
    print(difference);

    if (difference.inDays > 30) {
      return '${difference.inDays % 30} months ago';
    } else if (difference.inDays == 30) {
      return '1 month ago';
    } else if (difference.inDays > 8) {
      return dateTimeString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '1 week ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return '1 day ago';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return '1 hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return '1 minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static DateTime? getApiDatetoLocal(String? date) {
    if (date == null) return null;
    return _formatDateApi1.parse(date, true).toLocal() /*.toUtc()*/;
    return Intl.withLocale('en', () => _formatDateApi.parse(date).toUtc());
  }

  static DateTime? getApiDatetoLocalNew(String? date) {
    if (date == null) return null;
    return _formatBirthDateForServer.parse(date, true).toLocal() /*.toUtc()*/;
    return Intl.withLocale('en', () => _formatDateApi.parse(date).toUtc());
  }

  static String calculateDifference(String? dateTimeString) {
    // if (date == null) return '';
    var currentTime = DateTime.now();
    var diff = currentTime.difference(DateTime.parse(dateTimeString!));
    return (diff.inDays / 365).floor().toString();
  }
}
