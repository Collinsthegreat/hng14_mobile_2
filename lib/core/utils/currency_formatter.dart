import 'package:intl/intl.dart';

/// Currency formatter utility for multi-currency support.
///
/// This file provides utilities for formatting monetary amounts with
/// support for multiple currencies (NGN, USD, GBP, EUR, GHS, KES, ZAR).
/// It handles currency symbols, decimal places, and locale-specific formatting.

/// Enum representing supported currencies.
enum Currency {
  /// Nigerian Naira
  ngn,

  /// United States Dollar
  usd,

  /// British Pound Sterling
  gbp,

  /// Euro
  eur,

  /// Ghanaian Cedi
  ghs,

  /// Kenyan Shilling
  kes,

  /// South African Rand
  zar,
}

/// Extension on Currency enum to provide metadata.
extension CurrencyExtension on Currency {
  /// Returns the currency symbol.
  String get symbol {
    switch (this) {
      case Currency.ngn:
        return '₦';
      case Currency.usd:
        return '\$';
      case Currency.gbp:
        return '£';
      case Currency.eur:
        return '€';
      case Currency.ghs:
        return '₵';
      case Currency.kes:
        return 'KSh';
      case Currency.zar:
        return 'R';
    }
  }

  /// Returns the currency code (ISO 4217).
  String get code {
    switch (this) {
      case Currency.ngn:
        return 'NGN';
      case Currency.usd:
        return 'USD';
      case Currency.gbp:
        return 'GBP';
      case Currency.eur:
        return 'EUR';
      case Currency.ghs:
        return 'GHS';
      case Currency.kes:
        return 'KES';
      case Currency.zar:
        return 'ZAR';
    }
  }

  /// Returns the currency display name.
  String get displayName {
    switch (this) {
      case Currency.ngn:
        return 'Nigerian Naira';
      case Currency.usd:
        return 'US Dollar';
      case Currency.gbp:
        return 'British Pound';
      case Currency.eur:
        return 'Euro';
      case Currency.ghs:
        return 'Ghanaian Cedi';
      case Currency.kes:
        return 'Kenyan Shilling';
      case Currency.zar:
        return 'South African Rand';
    }
  }

  /// Returns the number of decimal places for the currency.
  int get decimalPlaces {
    // All supported currencies use 2 decimal places
    return 2;
  }

  /// Returns the locale string for the currency.
  String get locale {
    switch (this) {
      case Currency.ngn:
        return 'en_NG';
      case Currency.usd:
        return 'en_US';
      case Currency.gbp:
        return 'en_GB';
      case Currency.eur:
        return 'en_EU';
      case Currency.ghs:
        return 'en_GH';
      case Currency.kes:
        return 'en_KE';
      case Currency.zar:
        return 'en_ZA';
    }
  }
}

/// Utility class for formatting currency amounts.
class CurrencyFormatter {
  // Private constructor to prevent instantiation
  CurrencyFormatter._();

  /// Formats an amount with the specified currency.
  ///
  /// [amount] The monetary amount to format.
  /// [currency] The currency to use for formatting.
  /// [showSymbol] Whether to include the currency symbol (default: true).
  /// [showCode] Whether to include the currency code (default: false).
  /// [compact] Whether to use compact notation for large numbers (default: false).
  ///
  /// Returns a formatted string like "₦1,250.00" or "1,250.00 NGN".
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.format(1250.50, Currency.ngn); // "₦1,250.50"
  /// CurrencyFormatter.format(1250.50, Currency.usd, showCode: true); // "$1,250.50 USD"
  /// CurrencyFormatter.format(1250000, Currency.ngn, compact: true); // "₦1.25M"
  /// ```
  static String format(
    double amount,
    Currency currency, {
    bool showSymbol = true,
    bool showCode = false,
    bool compact = false,
  }) {
    if (compact && amount.abs() >= 1000) {
      return _formatCompact(amount, currency, showSymbol: showSymbol);
    }

    final formatter = NumberFormat.currency(
      locale: currency.locale,
      symbol: showSymbol ? currency.symbol : '',
      decimalDigits: currency.decimalPlaces,
    );

    final formattedAmount = formatter.format(amount);

    if (showCode) {
      return '$formattedAmount ${currency.code}';
    }

    return formattedAmount;
  }

  /// Formats an amount in compact notation (e.g., 1.25M, 500K).
  ///
  /// [amount] The monetary amount to format.
  /// [currency] The currency to use for formatting.
  /// [showSymbol] Whether to include the currency symbol (default: true).
  ///
  /// Returns a formatted string like "₦1.25M" or "₦500K".
  static String _formatCompact(
    double amount,
    Currency currency, {
    bool showSymbol = true,
  }) {
    final absAmount = amount.abs();
    final isNegative = amount < 0;
    final symbol = showSymbol ? currency.symbol : '';

    String compactValue;

    if (absAmount >= 1000000000) {
      // Billions
      compactValue = '${(absAmount / 1000000000).toStringAsFixed(2)}B';
    } else if (absAmount >= 1000000) {
      // Millions
      compactValue = '${(absAmount / 1000000).toStringAsFixed(2)}M';
    } else if (absAmount >= 1000) {
      // Thousands
      compactValue = '${(absAmount / 1000).toStringAsFixed(2)}K';
    } else {
      // Less than 1000, use regular formatting
      return format(amount, currency, showSymbol: showSymbol);
    }

    // Remove trailing zeros after decimal point
    compactValue = compactValue.replaceAll(RegExp(r'\.00'), '');

    return '${isNegative ? '-' : ''}$symbol$compactValue';
  }

  /// Formats an amount without currency symbol or code.
  ///
  /// [amount] The monetary amount to format.
  /// [decimalPlaces] Number of decimal places (default: 2).
  ///
  /// Returns a formatted string like "1,250.50".
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.formatPlain(1250.50); // "1,250.50"
  /// ```
  static String formatPlain(double amount, {int decimalPlaces = 2}) {
    final formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: decimalPlaces,
    );

    return formatter.format(amount).trim();
  }

  /// Parses a formatted currency string to a double value.
  ///
  /// [formattedAmount] The formatted currency string to parse.
  ///
  /// Returns the parsed double value, or null if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.parse("₦1,250.50"); // 1250.50
  /// CurrencyFormatter.parse("$1,250.50"); // 1250.50
  /// ```
  static double? parse(String formattedAmount) {
    try {
      // Remove currency symbols, spaces, and commas
      final cleanedAmount = formattedAmount
          .replaceAll(RegExp(r'[₦\$£€₵KShR,\s]'), '')
          .trim();

      return double.parse(cleanedAmount);
    } catch (e) {
      return null;
    }
  }

  /// Finds a currency by its code.
  ///
  /// [code] The currency code (e.g., "NGN", "USD").
  ///
  /// Returns the matching Currency enum value, or null if not found.
  /// The comparison is case-insensitive.
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.findByCode("NGN"); // Currency.ngn
  /// CurrencyFormatter.findByCode("usd"); // Currency.usd
  /// ```
  static Currency? findByCode(String code) {
    try {
      return Currency.values.firstWhere(
        (currency) => currency.code.toLowerCase() == code.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Finds a currency by its symbol.
  ///
  /// [symbol] The currency symbol (e.g., "₦", "$").
  ///
  /// Returns the matching Currency enum value, or null if not found.
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.findBySymbol("₦"); // Currency.ngn
  /// CurrencyFormatter.findBySymbol("\$"); // Currency.usd
  /// ```
  static Currency? findBySymbol(String symbol) {
    try {
      return Currency.values.firstWhere(
        (currency) => currency.symbol == symbol,
      );
    } catch (e) {
      return null;
    }
  }

  /// Returns all supported currencies.
  static List<Currency> get allCurrencies => Currency.values;

  /// Converts an amount from one currency to another.
  ///
  /// Note: This is a placeholder for future implementation.
  /// In a real app, this would use exchange rate APIs.
  ///
  /// [amount] The amount to convert.
  /// [from] The source currency.
  /// [to] The target currency.
  /// [exchangeRate] The exchange rate from source to target currency.
  ///
  /// Returns the converted amount.
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.convert(100, Currency.usd, Currency.ngn, 1500); // 150000
  /// ```
  static double convert(
    double amount,
    Currency from,
    Currency to,
    double exchangeRate,
  ) {
    if (from == to) return amount;
    return amount * exchangeRate;
  }

  /// Formats a currency amount with a sign prefix (+ or -).
  ///
  /// [amount] The monetary amount to format.
  /// [currency] The currency to use for formatting.
  /// [showSymbol] Whether to include the currency symbol (default: true).
  ///
  /// Returns a formatted string like "+₦1,250.00" or "-₦500.00".
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.formatWithSign(1250.50, Currency.ngn); // "+₦1,250.50"
  /// CurrencyFormatter.formatWithSign(-500, Currency.usd); // "-$500.00"
  /// ```
  static String formatWithSign(
    double amount,
    Currency currency, {
    bool showSymbol = true,
  }) {
    final formattedAmount = format(
      amount.abs(),
      currency,
      showSymbol: showSymbol,
    );

    if (amount >= 0) {
      return '+$formattedAmount';
    } else {
      return '-$formattedAmount';
    }
  }

  /// Validates if a string is a valid currency amount.
  ///
  /// [value] The string to validate.
  ///
  /// Returns true if the string represents a valid currency amount.
  ///
  /// Example:
  /// ```dart
  /// CurrencyFormatter.isValidAmount("1250.50"); // true
  /// CurrencyFormatter.isValidAmount("abc"); // false
  /// ```
  static bool isValidAmount(String value) {
    if (value.isEmpty) return false;

    final cleanedValue = value.replaceAll(RegExp(r'[₦\$£€₵KShR,\s]'), '');

    try {
      final amount = double.parse(cleanedValue);
      return amount >= 0;
    } catch (e) {
      return false;
    }
  }
}
