import 'package:intl/intl.dart';

/// Date utility functions for the Expense Tracker application.
///
/// This file provides utilities for date formatting, parsing, and manipulation.
/// It includes helpers for displaying dates in various formats, calculating
/// date ranges, and working with periods (daily, weekly, monthly, yearly).

/// Utility class for date operations.
class DateUtils {
  // Private constructor to prevent instantiation
  DateUtils._();

  // ============================================================================
  // Date Formatting
  // ============================================================================

  /// Formats a date in standard format (yyyy-MM-dd).
  ///
  /// Example: 2024-01-15
  static String formatStandard(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Formats a date in display format (MMM dd, yyyy).
  ///
  /// Example: Jan 15, 2024
  static String formatDisplay(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Formats a date in full format (MMMM dd, yyyy).
  ///
  /// Example: January 15, 2024
  static String formatFull(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  /// Formats a date in month-year format (MMMM yyyy).
  ///
  /// Example: January 2024
  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  /// Formats a date in short month-year format (MMM yyyy).
  ///
  /// Example: Jan 2024
  static String formatShortMonthYear(DateTime date) {
    return DateFormat('MMM yyyy').format(date);
  }

  /// Formats a date in day-month format (dd MMM).
  ///
  /// Example: 15 Jan
  static String formatDayMonth(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }

  /// Formats a time in 24-hour format (HH:mm).
  ///
  /// Example: 14:30
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  /// Formats a date and time in full format (yyyy-MM-dd HH:mm:ss).
  ///
  /// Example: 2024-01-15 14:30:00
  static String formatFullDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  /// Formats a date relative to today (Today, Yesterday, or date).
  ///
  /// Returns:
  /// - "Today" if the date is today
  /// - "Yesterday" if the date is yesterday
  /// - Formatted date (MMM dd, yyyy) otherwise
  ///
  /// Example:
  /// ```dart
  /// DateUtils.formatRelative(DateTime.now()); // "Today"
  /// DateUtils.formatRelative(DateTime.now().subtract(Duration(days: 1))); // "Yesterday"
  /// DateUtils.formatRelative(DateTime(2024, 1, 15)); // "Jan 15, 2024"
  /// ```
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else {
      return formatDisplay(date);
    }
  }

  /// Formats a date with time ago (e.g., "2 hours ago", "3 days ago").
  ///
  /// Returns a human-readable string representing how long ago the date was.
  ///
  /// Example:
  /// ```dart
  /// DateUtils.formatTimeAgo(DateTime.now().subtract(Duration(hours: 2))); // "2 hours ago"
  /// DateUtils.formatTimeAgo(DateTime.now().subtract(Duration(days: 3))); // "3 days ago"
  /// ```
  static String formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  // ============================================================================
  // Date Parsing
  // ============================================================================

  /// Parses a date string in standard format (yyyy-MM-dd).
  ///
  /// Returns the parsed DateTime, or null if parsing fails.
  static DateTime? parseStandard(String dateString) {
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parses a date string in display format (MMM dd, yyyy).
  ///
  /// Returns the parsed DateTime, or null if parsing fails.
  static DateTime? parseDisplay(String dateString) {
    try {
      return DateFormat('MMM dd, yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parses a date-time string in full format (yyyy-MM-dd HH:mm:ss).
  ///
  /// Returns the parsed DateTime, or null if parsing fails.
  static DateTime? parseFullDateTime(String dateTimeString) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }

  // ============================================================================
  // Date Comparison
  // ============================================================================

  /// Checks if two dates are on the same day.
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Checks if a date is today.
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// Checks if a date is yesterday.
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  /// Checks if a date is in the current week.
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = getStartOfWeek(now);
    final endOfWeek = getEndOfWeek(now);
    return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(seconds: 1)));
  }

  /// Checks if a date is in the current month.
  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Checks if a date is in the current year.
  static bool isThisYear(DateTime date) {
    return date.year == DateTime.now().year;
  }

  /// Checks if a date is in the past.
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Checks if a date is in the future.
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  // ============================================================================
  // Date Manipulation
  // ============================================================================

  /// Returns the start of the day (00:00:00).
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Returns the end of the day (23:59:59).
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Returns the start of the week (Monday 00:00:00).
  static DateTime getStartOfWeek(DateTime date) {
    final daysFromMonday = date.weekday - 1;
    final monday = date.subtract(Duration(days: daysFromMonday));
    return getStartOfDay(monday);
  }

  /// Returns the end of the week (Sunday 23:59:59).
  static DateTime getEndOfWeek(DateTime date) {
    final daysToSunday = 7 - date.weekday;
    final sunday = date.add(Duration(days: daysToSunday));
    return getEndOfDay(sunday);
  }

  /// Returns the start of the month (1st day 00:00:00).
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Returns the end of the month (last day 23:59:59).
  static DateTime getEndOfMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDay = nextMonth.subtract(const Duration(days: 1));
    return getEndOfDay(lastDay);
  }

  /// Returns the start of the year (January 1st 00:00:00).
  static DateTime getStartOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  /// Returns the end of the year (December 31st 23:59:59).
  static DateTime getEndOfYear(DateTime date) {
    return getEndOfDay(DateTime(date.year, 12, 31));
  }

  /// Adds a specified number of days to a date.
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Adds a specified number of weeks to a date.
  static DateTime addWeeks(DateTime date, int weeks) {
    return date.add(Duration(days: weeks * 7));
  }

  /// Adds a specified number of months to a date.
  static DateTime addMonths(DateTime date, int months) {
    int newMonth = date.month + months;
    int newYear = date.year;

    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }

    while (newMonth < 1) {
      newMonth += 12;
      newYear--;
    }

    // Handle day overflow (e.g., Jan 31 + 1 month = Feb 28/29)
    final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    final newDay = date.day > lastDayOfNewMonth ? lastDayOfNewMonth : date.day;

    return DateTime(
      newYear,
      newMonth,
      newDay,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
    );
  }

  /// Adds a specified number of years to a date.
  static DateTime addYears(DateTime date, int years) {
    return DateTime(
      date.year + years,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
    );
  }

  // ============================================================================
  // Date Range Helpers
  // ============================================================================

  /// Returns the number of days between two dates.
  static int daysBetween(DateTime start, DateTime end) {
    final startDate = getStartOfDay(start);
    final endDate = getStartOfDay(end);
    return endDate.difference(startDate).inDays;
  }

  /// Returns the number of weeks between two dates.
  static int weeksBetween(DateTime start, DateTime end) {
    return (daysBetween(start, end) / 7).floor();
  }

  /// Returns the number of months between two dates.
  static int monthsBetween(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + (end.month - start.month);
  }

  /// Returns the number of years between two dates.
  static int yearsBetween(DateTime start, DateTime end) {
    return end.year - start.year;
  }

  /// Returns a list of dates between start and end (inclusive).
  static List<DateTime> getDateRange(DateTime start, DateTime end) {
    final dates = <DateTime>[];
    var current = getStartOfDay(start);
    final endDate = getStartOfDay(end);

    while (current.isBefore(endDate) || isSameDay(current, endDate)) {
      dates.add(current);
      current = addDays(current, 1);
    }

    return dates;
  }

  /// Returns the number of days in a month.
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// Returns the number of days remaining in the current month.
  static int getRemainingDaysInMonth(DateTime date) {
    final endOfMonth = getEndOfMonth(date);
    return daysBetween(date, endOfMonth) + 1;
  }

  /// Returns the number of days remaining in the current week.
  static int getRemainingDaysInWeek(DateTime date) {
    final endOfWeek = getEndOfWeek(date);
    return daysBetween(date, endOfWeek) + 1;
  }

  /// Returns the number of days remaining in the current year.
  static int getRemainingDaysInYear(DateTime date) {
    final endOfYear = getEndOfYear(date);
    return daysBetween(date, endOfYear) + 1;
  }

  // ============================================================================
  // Period Helpers
  // ============================================================================

  /// Returns the date range for "This Week".
  static DateRange getThisWeekRange() {
    final now = DateTime.now();
    return DateRange(start: getStartOfWeek(now), end: getEndOfWeek(now));
  }

  /// Returns the date range for "This Month".
  static DateRange getThisMonthRange() {
    final now = DateTime.now();
    return DateRange(start: getStartOfMonth(now), end: getEndOfMonth(now));
  }

  /// Returns the date range for "This Year".
  static DateRange getThisYearRange() {
    final now = DateTime.now();
    return DateRange(start: getStartOfYear(now), end: getEndOfYear(now));
  }

  /// Returns the date range for "Last Week".
  static DateRange getLastWeekRange() {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));
    return DateRange(
      start: getStartOfWeek(lastWeek),
      end: getEndOfWeek(lastWeek),
    );
  }

  /// Returns the date range for "Last Month".
  static DateRange getLastMonthRange() {
    final now = DateTime.now();
    final lastMonth = addMonths(now, -1);
    return DateRange(
      start: getStartOfMonth(lastMonth),
      end: getEndOfMonth(lastMonth),
    );
  }

  /// Returns the date range for "Last Year".
  static DateRange getLastYearRange() {
    final now = DateTime.now();
    final lastYear = addYears(now, -1);
    return DateRange(
      start: getStartOfYear(lastYear),
      end: getEndOfYear(lastYear),
    );
  }

  /// Returns the date range for the last N days.
  static DateRange getLastNDaysRange(int days) {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: days - 1));
    return DateRange(start: getStartOfDay(start), end: getEndOfDay(now));
  }

  /// Returns the date range for the last N months.
  static DateRange getLastNMonthsRange(int months) {
    final now = DateTime.now();
    final start = addMonths(now, -months + 1);
    return DateRange(start: getStartOfMonth(start), end: getEndOfMonth(now));
  }
}

/// Data class representing a date range.
class DateRange {
  /// The start date of the range.
  final DateTime start;

  /// The end date of the range.
  final DateTime end;

  /// Creates a DateRange instance.
  const DateRange({required this.start, required this.end});

  /// Returns the number of days in the range.
  int get days => DateUtils.daysBetween(start, end) + 1;

  /// Returns whether the range contains a specific date.
  bool contains(DateTime date) {
    final dateOnly = DateUtils.getStartOfDay(date);
    final startOnly = DateUtils.getStartOfDay(start);
    final endOnly = DateUtils.getStartOfDay(end);

    return (dateOnly.isAfter(startOnly) ||
            dateOnly.isAtSameMomentAs(startOnly)) &&
        (dateOnly.isBefore(endOnly) || dateOnly.isAtSameMomentAs(endOnly));
  }

  /// Returns a formatted string representation of the range.
  String format() {
    return '${DateUtils.formatDisplay(start)} - ${DateUtils.formatDisplay(end)}';
  }

  @override
  String toString() {
    return 'DateRange(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DateRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
