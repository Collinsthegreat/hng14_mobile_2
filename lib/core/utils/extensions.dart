import 'package:flutter/material.dart';

/// Dart extensions for the Expense Tracker application.
///
/// This file provides extension methods on common Dart and Flutter types
/// to add convenient functionality throughout the app.

// ============================================================================
// String Extensions
// ============================================================================

/// Extension methods on String.
extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// "hello".capitalize(); // "Hello"
  /// "HELLO".capitalize(); // "HELLO"
  /// ```
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes the first letter of each word.
  ///
  /// Example:
  /// ```dart
  /// "hello world".capitalizeWords(); // "Hello World"
  /// "expense tracker app".capitalizeWords(); // "Expense Tracker App"
  /// ```
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Checks if the string is a valid number.
  ///
  /// Example:
  /// ```dart
  /// "123.45".isNumeric(); // true
  /// "abc".isNumeric(); // false
  /// ```
  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  /// Checks if the string is empty or contains only whitespace.
  ///
  /// Example:
  /// ```dart
  /// "".isBlank(); // true
  /// "   ".isBlank(); // true
  /// "hello".isBlank(); // false
  /// ```
  bool isBlank() {
    return trim().isEmpty;
  }

  /// Checks if the string is not empty and not only whitespace.
  ///
  /// Example:
  /// ```dart
  /// "hello".isNotBlank(); // true
  /// "".isNotBlank(); // false
  /// "   ".isNotBlank(); // false
  /// ```
  bool isNotBlank() {
    return !isBlank();
  }

  /// Truncates the string to a maximum length with ellipsis.
  ///
  /// Example:
  /// ```dart
  /// "Hello World".truncate(5); // "Hello..."
  /// "Hi".truncate(5); // "Hi"
  /// ```
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Removes all whitespace from the string.
  ///
  /// Example:
  /// ```dart
  /// "hello world".removeWhitespace(); // "helloworld"
  /// "  test  ".removeWhitespace(); // "test"
  /// ```
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Converts the string to a nullable double.
  ///
  /// Example:
  /// ```dart
  /// "123.45".toDoubleOrNull(); // 123.45
  /// "abc".toDoubleOrNull(); // null
  /// ```
  double? toDoubleOrNull() {
    return double.tryParse(this);
  }

  /// Converts the string to a nullable int.
  ///
  /// Example:
  /// ```dart
  /// "123".toIntOrNull(); // 123
  /// "abc".toIntOrNull(); // null
  /// ```
  int? toIntOrNull() {
    return int.tryParse(this);
  }

  /// Reverses the string.
  ///
  /// Example:
  /// ```dart
  /// "hello".reverse(); // "olleh"
  /// ```
  String reverse() {
    return split('').reversed.join('');
  }

  /// Checks if the string contains only alphabetic characters.
  ///
  /// Example:
  /// ```dart
  /// "hello".isAlpha(); // true
  /// "hello123".isAlpha(); // false
  /// ```
  bool isAlpha() {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  /// Checks if the string contains only alphanumeric characters.
  ///
  /// Example:
  /// ```dart
  /// "hello123".isAlphanumeric(); // true
  /// "hello 123".isAlphanumeric(); // false
  /// ```
  bool isAlphanumeric() {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }
}

// ============================================================================
// DateTime Extensions
// ============================================================================

/// Extension methods on DateTime.
extension DateTimeExtension on DateTime {
  /// Checks if the date is today.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().isToday(); // true
  /// DateTime.now().subtract(Duration(days: 1)).isToday(); // false
  /// ```
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if the date is yesterday.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().subtract(Duration(days: 1)).isYesterday(); // true
  /// DateTime.now().isYesterday(); // false
  /// ```
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Checks if the date is tomorrow.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().add(Duration(days: 1)).isTomorrow(); // true
  /// DateTime.now().isTomorrow(); // false
  /// ```
  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Checks if the date is in the current week.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().isThisWeek(); // true
  /// ```
  bool isThisWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        isBefore(endOfWeek.add(const Duration(seconds: 1)));
  }

  /// Checks if the date is in the current month.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().isThisMonth(); // true
  /// ```
  bool isThisMonth() {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Checks if the date is in the current year.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().isThisYear(); // true
  /// ```
  bool isThisYear() {
    return year == DateTime.now().year;
  }

  /// Checks if the date is in the past.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().subtract(Duration(days: 1)).isPast(); // true
  /// DateTime.now().add(Duration(days: 1)).isPast(); // false
  /// ```
  bool isPast() {
    return isBefore(DateTime.now());
  }

  /// Checks if the date is in the future.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().add(Duration(days: 1)).isFuture(); // true
  /// DateTime.now().subtract(Duration(days: 1)).isFuture(); // false
  /// ```
  bool isFuture() {
    return isAfter(DateTime.now());
  }

  /// Returns the date with time set to 00:00:00.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 1, 15, 14, 30).startOfDay(); // 2024-01-15 00:00:00
  /// ```
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  /// Returns the date with time set to 23:59:59.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 1, 15, 14, 30).endOfDay(); // 2024-01-15 23:59:59
  /// ```
  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Adds a specified number of days.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 1, 15).addDays(5); // 2024-01-20
  /// ```
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// Subtracts a specified number of days.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 1, 15).subtractDays(5); // 2024-01-10
  /// ```
  DateTime subtractDays(int days) {
    return subtract(Duration(days: days));
  }

  /// Checks if two dates are on the same day.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 1, 15, 10, 0).isSameDay(DateTime(2024, 1, 15, 20, 0)); // true
  /// DateTime(2024, 1, 15).isSameDay(DateTime(2024, 1, 16)); // false
  /// ```
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns the number of days between this date and another.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 1, 15).daysBetween(DateTime(2024, 1, 20)); // 5
  /// ```
  int daysBetween(DateTime other) {
    final from = startOfDay();
    final to = other.startOfDay();
    return (to.difference(from).inHours / 24).round();
  }
}

// ============================================================================
// double Extensions
// ============================================================================

/// Extension methods on double.
extension DoubleExtension on double {
  /// Rounds to a specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// 3.14159.roundToDecimal(2); // 3.14
  /// 3.14159.roundToDecimal(4); // 3.1416
  /// ```
  double roundToDecimal(int places) {
    final mod = 10.0 * places;
    return (this * mod).round() / mod;
  }

  /// Formats the number with thousand separators.
  ///
  /// Example:
  /// ```dart
  /// 1234567.89.withCommas(); // "1,234,567.89"
  /// ```
  String withCommas({int decimals = 2}) {
    return toStringAsFixed(decimals).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  /// Checks if the number is positive.
  ///
  /// Example:
  /// ```dart
  /// 5.0.isPositive(); // true
  /// (-5.0).isPositive(); // false
  /// ```
  bool isPositive() {
    return this > 0;
  }

  /// Checks if the number is negative.
  ///
  /// Example:
  /// ```dart
  /// (-5.0).isNegative(); // true
  /// 5.0.isNegative(); // false
  /// ```
  bool isNegative() {
    return this < 0;
  }

  /// Checks if the number is zero.
  ///
  /// Example:
  /// ```dart
  /// 0.0.isZero(); // true
  /// 5.0.isZero(); // false
  /// ```
  bool isZero() {
    return this == 0;
  }

  /// Clamps the value between a minimum and maximum.
  ///
  /// Example:
  /// ```dart
  /// 5.0.clampValue(0, 10); // 5.0
  /// 15.0.clampValue(0, 10); // 10.0
  /// (-5.0).clampValue(0, 10); // 0.0
  /// ```
  double clampValue(double min, double max) {
    return clamp(min, max).toDouble();
  }

  /// Converts to a percentage string.
  ///
  /// Example:
  /// ```dart
  /// 0.75.toPercentage(); // "75%"
  /// 0.5.toPercentage(decimals: 1); // "50.0%"
  /// ```
  String toPercentage({int decimals = 0}) {
    return '${(this * 100).toStringAsFixed(decimals)}%';
  }
}

// ============================================================================
// int Extensions
// ============================================================================

/// Extension methods on int.
extension IntExtension on int {
  /// Checks if the number is even.
  ///
  /// Example:
  /// ```dart
  /// 4.isEven(); // true
  /// 5.isEven(); // false
  /// ```
  bool isEvenNumber() {
    return this % 2 == 0;
  }

  /// Checks if the number is odd.
  ///
  /// Example:
  /// ```dart
  /// 5.isOdd(); // true
  /// 4.isOdd(); // false
  /// ```
  bool isOddNumber() {
    return this % 2 != 0;
  }

  /// Formats the number with thousand separators.
  ///
  /// Example:
  /// ```dart
  /// 1234567.withCommas(); // "1,234,567"
  /// ```
  String withCommas() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  /// Converts to ordinal string (1st, 2nd, 3rd, etc.).
  ///
  /// Example:
  /// ```dart
  /// 1.toOrdinal(); // "1st"
  /// 2.toOrdinal(); // "2nd"
  /// 3.toOrdinal(); // "3rd"
  /// 21.toOrdinal(); // "21st"
  /// ```
  String toOrdinal() {
    if (this % 100 >= 11 && this % 100 <= 13) {
      return '${this}th';
    }

    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

// ============================================================================
// List Extensions
// ============================================================================

/// Extension methods on List.
extension ListExtension<T> on List<T> {
  /// Returns the first element or null if the list is empty.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].firstOrNull(); // 1
  /// [].firstOrNull(); // null
  /// ```
  T? firstOrNull() {
    return isEmpty ? null : first;
  }

  /// Returns the last element or null if the list is empty.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].lastOrNull(); // 3
  /// [].lastOrNull(); // null
  /// ```
  T? lastOrNull() {
    return isEmpty ? null : last;
  }

  /// Returns a random element from the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].random(); // Random element
  /// ```
  T? random() {
    if (isEmpty) return null;
    return this[(length * (DateTime.now().millisecondsSinceEpoch % length)) ~/
        length];
  }

  /// Groups elements by a key function.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].groupBy((n) => n % 2 == 0 ? 'even' : 'odd');
  /// // {'odd': [1, 3, 5], 'even': [2, 4]}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keyFunction(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  /// Sums numeric values in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].sum(); // 15
  /// ```
  num sum() {
    return fold(0, (prev, element) => prev + (element as num));
  }

  /// Calculates the average of numeric values in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].average(); // 3.0
  /// ```
  double average() {
    if (isEmpty) return 0;
    return sum() / length;
  }
}

// ============================================================================
// BuildContext Extensions
// ============================================================================

/// Extension methods on BuildContext.
extension BuildContextExtension on BuildContext {
  /// Returns the current theme.
  ///
  /// Example:
  /// ```dart
  /// context.theme; // ThemeData
  /// ```
  ThemeData get theme => Theme.of(this);

  /// Returns the current text theme.
  ///
  /// Example:
  /// ```dart
  /// context.textTheme; // TextTheme
  /// ```
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the current color scheme.
  ///
  /// Example:
  /// ```dart
  /// context.colorScheme; // ColorScheme
  /// ```
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the screen size.
  ///
  /// Example:
  /// ```dart
  /// context.screenSize; // Size
  /// ```
  Size get screenSize => MediaQuery.of(this).size;

  /// Returns the screen width.
  ///
  /// Example:
  /// ```dart
  /// context.screenWidth; // double
  /// ```
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the screen height.
  ///
  /// Example:
  /// ```dart
  /// context.screenHeight; // double
  /// ```
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Checks if the device is in dark mode.
  ///
  /// Example:
  /// ```dart
  /// context.isDarkMode; // bool
  /// ```
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Checks if the device is in light mode.
  ///
  /// Example:
  /// ```dart
  /// context.isLightMode; // bool
  /// ```
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// Shows a snackbar with a message.
  ///
  /// Example:
  /// ```dart
  /// context.showSnackBar("Transaction added successfully");
  /// ```
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Hides the keyboard.
  ///
  /// Example:
  /// ```dart
  /// context.hideKeyboard();
  /// ```
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Checks if the keyboard is visible.
  ///
  /// Example:
  /// ```dart
  /// context.isKeyboardVisible; // bool
  /// ```
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;
}
