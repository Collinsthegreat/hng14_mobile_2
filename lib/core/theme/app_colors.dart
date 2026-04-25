import 'package:flutter/material.dart';

/// Application-wide color constants.
///
/// This file defines all colors used throughout the app for consistency.
/// Colors are organized by purpose: primary/secondary theme colors,
/// semantic colors (income, expense, warning), and light/dark theme surfaces.
///
/// All colors follow Material Design 3 guidelines and are optimized
/// for both light and dark themes.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============================================================================
  // Primary Theme Colors
  // ============================================================================

  /// Primary brand color - Deep Indigo
  ///
  /// Used for primary actions, app bars, and key UI elements.
  /// This color represents the app's brand identity.
  static const Color primary = Color(0xFF3D5AFE);

  /// Secondary brand color - Teal
  ///
  /// Used for secondary actions, accents, and complementary UI elements.
  static const Color secondary = Color(0xFF00BCD4);

  // ============================================================================
  // Semantic Colors
  // ============================================================================

  /// Income color - Green
  ///
  /// Used to represent positive cash flow, income transactions,
  /// and positive balance changes.
  static const Color income = Color(0xFF4CAF50);

  /// Expense color - Red
  ///
  /// Used to represent negative cash flow, expense transactions,
  /// and negative balance changes.
  static const Color expense = Color(0xFFF44336);

  /// Warning color - Orange
  ///
  /// Used for warning states, budget alerts (70-90% spent),
  /// and cautionary messages.
  static const Color warning = Color(0xFFFF9800);

  /// Success color - Green
  ///
  /// Used for success states, confirmations, and positive feedback.
  /// Same as income color for consistency.
  static const Color success = Color(0xFF4CAF50);

  /// Error color - Red
  ///
  /// Used for error states, validation failures, and critical alerts.
  /// Same as expense color for consistency.
  static const Color error = Color(0xFFF44336);

  /// Info color - Blue
  ///
  /// Used for informational messages and neutral notifications.
  static const Color info = Color(0xFF2196F3);

  // ============================================================================
  // Budget Status Colors
  // ============================================================================

  /// Budget on track color - Green
  ///
  /// Used when budget spending is below 70% of the limit.
  static const Color budgetOnTrack = Color(0xFF4CAF50);

  /// Budget warning color - Orange
  ///
  /// Used when budget spending is between 70-90% of the limit.
  static const Color budgetWarning = Color(0xFFFF9800);

  /// Budget exceeded color - Red
  ///
  /// Used when budget spending exceeds 90% of the limit.
  static const Color budgetExceeded = Color(0xFFF44336);

  // ============================================================================
  // Light Theme Colors
  // ============================================================================

  /// Light theme surface color
  ///
  /// Used for cards, sheets, and elevated surfaces in light mode.
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Light theme background color
  ///
  /// Used for screen backgrounds and base surfaces in light mode.
  static const Color backgroundLight = Color(0xFFF5F5F5);

  /// Light theme text color - Primary
  ///
  /// Used for primary text content in light mode.
  static const Color textPrimaryLight = Color(0xFF212121);

  /// Light theme text color - Secondary
  ///
  /// Used for secondary text content in light mode.
  static const Color textSecondaryLight = Color(0xFF757575);

  /// Light theme divider color
  ///
  /// Used for dividers and borders in light mode.
  static const Color dividerLight = Color(0xFFE0E0E0);

  // ============================================================================
  // Dark Theme Colors
  // ============================================================================

  /// Dark theme surface color
  ///
  /// Used for cards, sheets, and elevated surfaces in dark mode.
  static const Color surfaceDark = Color(0xFF121212);

  /// Dark theme background color
  ///
  /// Used for screen backgrounds and base surfaces in dark mode.
  static const Color backgroundDark = Color(0xFF000000);

  /// Dark theme text color - Primary
  ///
  /// Used for primary text content in dark mode.
  static const Color textPrimaryDark = Color(0xFFFFFFFF);

  /// Dark theme text color - Secondary
  ///
  /// Used for secondary text content in dark mode.
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  /// Dark theme divider color
  ///
  /// Used for dividers and borders in dark mode.
  static const Color dividerDark = Color(0xFF2C2C2C);

  // ============================================================================
  // Gradient Colors
  // ============================================================================

  /// Primary gradient start color
  ///
  /// Used as the starting color for primary gradients (e.g., balance card).
  static const Color gradientPrimaryStart = Color(0xFF3D5AFE);

  /// Primary gradient end color
  ///
  /// Used as the ending color for primary gradients (e.g., balance card).
  static const Color gradientPrimaryEnd = Color(0xFF00BCD4);

  /// Income gradient start color
  ///
  /// Used as the starting color for income-related gradients.
  static const Color gradientIncomeStart = Color(0xFF4CAF50);

  /// Income gradient end color
  ///
  /// Used as the ending color for income-related gradients.
  static const Color gradientIncomeEnd = Color(0xFF8BC34A);

  /// Expense gradient start color
  ///
  /// Used as the starting color for expense-related gradients.
  static const Color gradientExpenseStart = Color(0xFFF44336);

  /// Expense gradient end color
  ///
  /// Used as the ending color for expense-related gradients.
  static const Color gradientExpenseEnd = Color(0xFFFF5722);

  // ============================================================================
  // Utility Colors
  // ============================================================================

  /// Transparent color
  ///
  /// Used for transparent overlays and backgrounds.
  static const Color transparent = Color(0x00000000);

  /// White color
  ///
  /// Used for white text, icons, and surfaces.
  static const Color white = Color(0xFFFFFFFF);

  /// Black color
  ///
  /// Used for black text, icons, and surfaces.
  static const Color black = Color(0xFF000000);

  /// Grey color - Light
  ///
  /// Used for disabled states and subtle UI elements.
  static const Color greyLight = Color(0xFFBDBDBD);

  /// Grey color - Medium
  ///
  /// Used for borders and dividers.
  static const Color greyMedium = Color(0xFF9E9E9E);

  /// Grey color - Dark
  ///
  /// Used for secondary text and icons.
  static const Color greyDark = Color(0xFF616161);

  // ============================================================================
  // Overlay Colors
  // ============================================================================

  /// Overlay color for light theme
  ///
  /// Used for modal overlays and dimmed backgrounds in light mode.
  static const Color overlayLight = Color(0x52000000); // 32% opacity black

  /// Overlay color for dark theme
  ///
  /// Used for modal overlays and dimmed backgrounds in dark mode.
  static const Color overlayDark = Color(0x52000000); // 32% opacity black

  // ============================================================================
  // Helper Methods
  // ============================================================================

  /// Returns the appropriate text color based on background brightness.
  ///
  /// This method calculates the luminance of the background color and
  /// returns either white or black text color for optimal contrast.
  ///
  /// [backgroundColor] The background color to check against.
  static Color getContrastingTextColor(Color backgroundColor) {
    // Calculate luminance using the relative luminance formula
    final double luminance = backgroundColor.computeLuminance();

    // Return white text for dark backgrounds, black text for light backgrounds
    return luminance > 0.5 ? black : white;
  }

  /// Returns the budget status color based on percentage spent.
  ///
  /// [percentageSpent] The percentage of budget spent (0-100+).
  ///
  /// Returns:
  /// - Green if less than 70%
  /// - Orange if between 70-90%
  /// - Red if 90% or more
  static Color getBudgetStatusColor(double percentageSpent) {
    if (percentageSpent < 70) {
      return budgetOnTrack;
    } else if (percentageSpent < 90) {
      return budgetWarning;
    } else {
      return budgetExceeded;
    }
  }

  /// Returns a color with adjusted opacity.
  ///
  /// [color] The base color to adjust.
  /// [opacity] The opacity value (0.0 to 1.0).
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity.clamp(0.0, 1.0));
  }

  /// Returns a lighter shade of the given color.
  ///
  /// [color] The base color to lighten.
  /// [amount] The amount to lighten (0.0 to 1.0).
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Returns a darker shade of the given color.
  ///
  /// [color] The base color to darken.
  /// [amount] The amount to darken (0.0 to 1.0).
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }
}
