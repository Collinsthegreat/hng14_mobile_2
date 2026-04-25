/// Form validation utilities for the Expense Tracker application.
///
/// This file provides validation functions for form inputs including
/// transaction titles, amounts, categories, budget limits, and other
/// user inputs. All validators return null if valid, or an error message
/// string if invalid (following Flutter's FormField validator pattern).
library;

/// Utility class for form validation.
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  // ============================================================================
  // Transaction Validators
  // ============================================================================

  /// Validates a transaction title.
  ///
  /// Rules:
  /// - Must not be empty
  /// - Must not exceed maximum length (100 characters)
  /// - Must not contain only whitespace
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.validateTitle("Lunch"); // null (valid)
  /// Validators.validateTitle(""); // "Title is required"
  /// Validators.validateTitle("   "); // "Title cannot be empty"
  /// ```
  static String? validateTitle(String? value, {int maxLength = 100}) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }

    if (value.trim().isEmpty) {
      return 'Title cannot be empty';
    }

    if (value.length > maxLength) {
      return 'Title must not exceed $maxLength characters';
    }

    return null;
  }

  /// Validates a transaction amount.
  ///
  /// Rules:
  /// - Must not be empty
  /// - Must be a valid number
  /// - Must be greater than zero
  /// - Must not exceed maximum amount
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.validateAmount("100.50"); // null (valid)
  /// Validators.validateAmount(""); // "Amount is required"
  /// Validators.validateAmount("0"); // "Amount must be greater than zero"
  /// Validators.validateAmount("abc"); // "Please enter a valid amount"
  /// ```
  static String? validateAmount(
    String? value, {
    double minAmount = 0.01,
    double maxAmount = 999999999.99,
  }) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }

    // Remove currency symbols and commas
    final cleanedValue = value.replaceAll(RegExp(r'[₦\$£€₵KShR,\s]'), '');

    final amount = double.tryParse(cleanedValue);

    if (amount == null) {
      return 'Please enter a valid amount';
    }

    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }

    if (amount < minAmount) {
      return 'Amount must be at least $minAmount';
    }

    if (amount > maxAmount) {
      return 'Amount must not exceed $maxAmount';
    }

    return null;
  }

  /// Validates a transaction note.
  ///
  /// Rules:
  /// - Optional field (can be empty)
  /// - Must not exceed maximum length (500 characters)
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.validateNote("Lunch with team"); // null (valid)
  /// Validators.validateNote(""); // null (valid, optional)
  /// Validators.validateNote("Very long note..."); // Error if > 500 chars
  /// ```
  static String? validateNote(String? value, {int maxLength = 500}) {
    // Note is optional, so null or empty is valid
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > maxLength) {
      return 'Note must not exceed $maxLength characters';
    }

    return null;
  }

  /// Validates that a category is selected.
  ///
  /// Rules:
  /// - Must not be null
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.validateCategory(TransactionCategory.food); // null (valid)
  /// Validators.validateCategory(null); // "Category is required"
  /// ```
  static String? validateCategory(dynamic value) {
    if (value == null) {
      return 'Category is required';
    }

    return null;
  }

  /// Validates a transaction date.
  ///
  /// Rules:
  /// - Must not be null
  /// - Optional: Must not be in the future (if allowFuture is false)
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.validateDate(DateTime.now()); // null (valid)
  /// Validators.validateDate(null); // "Date is required"
  /// Validators.validateDate(DateTime.now().add(Duration(days: 1)), allowFuture: false); // "Date cannot be in the future"
  /// ```
  static String? validateDate(DateTime? value, {bool allowFuture = true}) {
    if (value == null) {
      return 'Date is required';
    }

    if (!allowFuture && value.isAfter(DateTime.now())) {
      return 'Date cannot be in the future';
    }

    return null;
  }

  // ============================================================================
  // Budget Validators
  // ============================================================================

  /// Validates a budget limit amount.
  ///
  /// Rules:
  /// - Must not be empty
  /// - Must be a valid number
  /// - Must be greater than zero
  /// - Must not exceed maximum amount
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.validateBudgetLimit("5000"); // null (valid)
  /// Validators.validateBudgetLimit(""); // "Limit is required"
  /// Validators.validateBudgetLimit("0"); // "Limit must be greater than zero"
  /// ```
  static String? validateBudgetLimit(
    String? value, {
    double minAmount = 0.01,
    double maxAmount = 999999999.99,
  }) {
    if (value == null || value.isEmpty) {
      return 'Limit is required';
    }

    // Remove currency symbols and commas
    final cleanedValue = value.replaceAll(RegExp(r'[₦\$£€₵KShR,\s]'), '');

    final amount = double.tryParse(cleanedValue);

    if (amount == null) {
      return 'Please enter a valid limit';
    }

    if (amount <= 0) {
      return 'Limit must be greater than zero';
    }

    if (amount < minAmount) {
      return 'Limit must be at least $minAmount';
    }

    if (amount > maxAmount) {
      return 'Limit must not exceed $maxAmount';
    }

    return null;
  }

  /// Validates that a budget period is selected.
  ///
  /// Rules:
  /// - Must not be null
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.validateBudgetPeriod(BudgetPeriod.monthly); // null (valid)
  /// Validators.validateBudgetPeriod(null); // "Period is required"
  /// ```
  static String? validateBudgetPeriod(dynamic value) {
    if (value == null) {
      return 'Period is required';
    }

    return null;
  }

  // ============================================================================
  // General Validators
  // ============================================================================

  /// Validates that a field is not empty.
  ///
  /// Rules:
  /// - Must not be null or empty
  /// - Must not contain only whitespace
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.required("value"); // null (valid)
  /// Validators.required(""); // "This field is required"
  /// Validators.required("   "); // "This field is required"
  /// ```
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return fieldName != null
          ? '$fieldName is required'
          : 'This field is required';
    }

    return null;
  }

  /// Validates minimum length.
  ///
  /// Rules:
  /// - Must have at least minLength characters
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.minLength("hello", 3); // null (valid)
  /// Validators.minLength("hi", 3); // "Must be at least 3 characters"
  /// ```
  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.length < minLength) {
      return fieldName != null
          ? '$fieldName must be at least $minLength characters'
          : 'Must be at least $minLength characters';
    }

    return null;
  }

  /// Validates maximum length.
  ///
  /// Rules:
  /// - Must not exceed maxLength characters
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.maxLength("hello", 10); // null (valid)
  /// Validators.maxLength("hello world!", 10); // "Must not exceed 10 characters"
  /// ```
  static String? maxLength(String? value, int maxLength, {String? fieldName}) {
    if (value != null && value.length > maxLength) {
      return fieldName != null
          ? '$fieldName must not exceed $maxLength characters'
          : 'Must not exceed $maxLength characters';
    }

    return null;
  }

  /// Validates that a value is a valid number.
  ///
  /// Rules:
  /// - Must be parseable as a double
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.isNumber("123.45"); // null (valid)
  /// Validators.isNumber("abc"); // "Please enter a valid number"
  /// ```
  static String? isNumber(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Use required() for non-empty validation
    }

    if (double.tryParse(value) == null) {
      return fieldName != null
          ? 'Please enter a valid $fieldName'
          : 'Please enter a valid number';
    }

    return null;
  }

  /// Validates that a value is a positive number.
  ///
  /// Rules:
  /// - Must be parseable as a double
  /// - Must be greater than zero
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.isPositive("123.45"); // null (valid)
  /// Validators.isPositive("-10"); // "Must be a positive number"
  /// Validators.isPositive("0"); // "Must be greater than zero"
  /// ```
  static String? isPositive(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Use required() for non-empty validation
    }

    final number = double.tryParse(value);

    if (number == null) {
      return fieldName != null
          ? 'Please enter a valid $fieldName'
          : 'Please enter a valid number';
    }

    if (number <= 0) {
      return fieldName != null
          ? '$fieldName must be greater than zero'
          : 'Must be greater than zero';
    }

    return null;
  }

  /// Validates a value against a minimum number.
  ///
  /// Rules:
  /// - Must be parseable as a double
  /// - Must be greater than or equal to min
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.min("10", 5); // null (valid)
  /// Validators.min("3", 5); // "Must be at least 5"
  /// ```
  static String? min(String? value, double min, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Use required() for non-empty validation
    }

    final number = double.tryParse(value);

    if (number == null) {
      return 'Please enter a valid number';
    }

    if (number < min) {
      return fieldName != null
          ? '$fieldName must be at least $min'
          : 'Must be at least $min';
    }

    return null;
  }

  /// Validates a value against a maximum number.
  ///
  /// Rules:
  /// - Must be parseable as a double
  /// - Must be less than or equal to max
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.max("10", 20); // null (valid)
  /// Validators.max("25", 20); // "Must not exceed 20"
  /// ```
  static String? max(String? value, double max, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Use required() for non-empty validation
    }

    final number = double.tryParse(value);

    if (number == null) {
      return 'Please enter a valid number';
    }

    if (number > max) {
      return fieldName != null
          ? '$fieldName must not exceed $max'
          : 'Must not exceed $max';
    }

    return null;
  }

  /// Validates a value is within a range.
  ///
  /// Rules:
  /// - Must be parseable as a double
  /// - Must be between min and max (inclusive)
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// Validators.range("10", 5, 20); // null (valid)
  /// Validators.range("3", 5, 20); // "Must be between 5 and 20"
  /// Validators.range("25", 5, 20); // "Must be between 5 and 20"
  /// ```
  static String? range(
    String? value,
    double min,
    double max, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return null; // Use required() for non-empty validation
    }

    final number = double.tryParse(value);

    if (number == null) {
      return 'Please enter a valid number';
    }

    if (number < min || number > max) {
      return fieldName != null
          ? '$fieldName must be between $min and $max'
          : 'Must be between $min and $max';
    }

    return null;
  }

  // ============================================================================
  // Composite Validators
  // ============================================================================

  /// Combines multiple validators into one.
  ///
  /// Returns the first error message encountered, or null if all pass.
  ///
  /// Example:
  /// ```dart
  /// final validator = Validators.compose([
  ///   (value) => Validators.required(value),
  ///   (value) => Validators.minLength(value, 3),
  ///   (value) => Validators.maxLength(value, 100),
  /// ]);
  /// validator("hi"); // "Must be at least 3 characters"
  /// ```
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// Creates a validator that checks if value matches a pattern.
  ///
  /// Rules:
  /// - Must match the provided regex pattern
  ///
  /// Returns null if valid, error message otherwise.
  ///
  /// Example:
  /// ```dart
  /// final emailValidator = Validators.pattern(
  ///   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ///   'Please enter a valid email',
  /// );
  /// emailValidator("test@example.com"); // null (valid)
  /// emailValidator("invalid"); // "Please enter a valid email"
  /// ```
  static String? pattern(String? value, String pattern, String errorMessage) {
    if (value == null || value.isEmpty) {
      return null; // Use required() for non-empty validation
    }

    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }
}
