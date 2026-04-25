import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application-wide typography definitions.
///
/// This file defines all text styles used throughout the app for consistency.
/// All text styles use the Inter font family from Google Fonts and follow
/// Material Design 3 typography guidelines.
///
/// Text styles are organized by size and weight, with responsive sizing
/// support using flutter_screenutil (when initialized).
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // ============================================================================
  // Font Family
  // ============================================================================

  /// Base font family for the app.
  ///
  /// Uses Inter from Google Fonts for a modern, clean appearance.
  /// Inter is optimized for UI and provides excellent readability.
  static final String fontFamily = GoogleFonts.inter().fontFamily!;

  // ============================================================================
  // Display Text Styles (Largest)
  // ============================================================================

  /// Display Large - 57sp
  ///
  /// Used for the largest text on screen, such as hero numbers or
  /// prominent display values (e.g., large balance amounts).
  static TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  /// Display Medium - 45sp
  ///
  /// Used for large display text, slightly smaller than displayLarge.
  static TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );

  /// Display Small - 36sp
  ///
  /// Used for smaller display text, such as section headers.
  static TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );

  // ============================================================================
  // Headline Text Styles
  // ============================================================================

  /// Headline Large - 32sp
  ///
  /// Used for large headlines, such as page titles or major section headers.
  static TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    letterSpacing: 0,
    height: 1.25,
  );

  /// Headline Medium - 28sp
  ///
  /// Used for medium headlines, such as card titles or dialog headers.
  static TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0,
    height: 1.29,
  );

  /// Headline Small - 24sp
  ///
  /// Used for smaller headlines, such as list section headers.
  static TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0,
    height: 1.33,
  );

  // ============================================================================
  // Title Text Styles
  // ============================================================================

  /// Title Large - 22sp
  ///
  /// Used for large titles, such as app bar titles.
  static TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0,
    height: 1.27,
  );

  /// Title Medium - 16sp
  ///
  /// Used for medium titles, such as card headers or list item titles.
  static TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0.15,
    height: 1.50,
  );

  /// Title Small - 14sp
  ///
  /// Used for small titles, such as compact card headers.
  static TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0.1,
    height: 1.43,
  );

  // ============================================================================
  // Body Text Styles
  // ============================================================================

  /// Body Large - 16sp
  ///
  /// Used for large body text, such as primary content or descriptions.
  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.5,
    height: 1.50,
  );

  /// Body Medium - 14sp
  ///
  /// Used for medium body text, the most common text style for content.
  static TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.25,
    height: 1.43,
  );

  /// Body Small - 12sp
  ///
  /// Used for small body text, such as captions or helper text.
  static TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.4,
    height: 1.33,
  );

  // ============================================================================
  // Label Text Styles
  // ============================================================================

  /// Label Large - 14sp
  ///
  /// Used for large labels, such as button text or prominent labels.
  static TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// Label Medium - 12sp
  ///
  /// Used for medium labels, such as form field labels or chip text.
  static TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.5,
    height: 1.33,
  );

  /// Label Small - 11sp
  ///
  /// Used for small labels, such as timestamps or metadata.
  static TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.5,
    height: 1.45,
  );

  // ============================================================================
  // Custom App-Specific Text Styles
  // ============================================================================

  /// Balance Display - 48sp
  ///
  /// Used for displaying the main balance amount on the dashboard.
  /// Extra bold weight for emphasis.
  static TextStyle balanceDisplay = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w800, // Extra bold
    letterSpacing: -0.5,
    height: 1.0,
  );

  /// Amount Large - 24sp
  ///
  /// Used for displaying large transaction amounts.
  static TextStyle amountLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700, // Bold
    letterSpacing: 0,
    height: 1.2,
  );

  /// Amount Medium - 18sp
  ///
  /// Used for displaying medium transaction amounts in lists.
  static TextStyle amountMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0,
    height: 1.3,
  );

  /// Amount Small - 14sp
  ///
  /// Used for displaying small transaction amounts or summaries.
  static TextStyle amountSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0,
    height: 1.4,
  );

  /// Button Text - 14sp
  ///
  /// Used for button labels with medium weight.
  static TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.1,
    height: 1.0,
  );

  /// Caption - 12sp
  ///
  /// Used for captions, timestamps, and supplementary information.
  static TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.4,
    height: 1.33,
  );

  /// Overline - 10sp
  ///
  /// Used for overline text, such as category labels or section markers.
  static TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 1.5,
    height: 1.6,
  );

  // ============================================================================
  // Helper Methods
  // ============================================================================

  /// Returns a text style with a specific color.
  ///
  /// [style] The base text style to modify.
  /// [color] The color to apply.
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Returns a text style with a specific font weight.
  ///
  /// [style] The base text style to modify.
  /// [weight] The font weight to apply.
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Returns a text style with a specific font size.
  ///
  /// [style] The base text style to modify.
  /// [size] The font size to apply.
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Returns a text style with italic styling.
  ///
  /// [style] The base text style to modify.
  static TextStyle italic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }

  /// Returns a text style with underline decoration.
  ///
  /// [style] The base text style to modify.
  static TextStyle underline(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.underline);
  }

  /// Returns a text style with line-through decoration.
  ///
  /// [style] The base text style to modify.
  static TextStyle lineThrough(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.lineThrough);
  }

  /// Returns a text style with custom letter spacing.
  ///
  /// [style] The base text style to modify.
  /// [spacing] The letter spacing to apply.
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }

  /// Returns a text style with custom line height.
  ///
  /// [style] The base text style to modify.
  /// [height] The line height multiplier to apply.
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  // ============================================================================
  // Responsive Typography (for use with flutter_screenutil)
  // ============================================================================

  /// Creates a responsive text style based on screen size.
  ///
  /// This method is designed to work with flutter_screenutil.
  /// Once flutter_screenutil is initialized, you can use .sp extension
  /// on font sizes for responsive scaling.
  ///
  /// Example usage with screenutil:
  /// ```dart
  /// TextStyle(
  ///   fontSize: 16.sp,  // Responsive font size
  ///   height: 1.5.h,    // Responsive line height
  /// )
  /// ```
  ///
  /// [baseStyle] The base text style to make responsive.
  static TextStyle responsive(TextStyle baseStyle) {
    // ScreenUtil is initialized and used throughout the UI layer.
    // Base styles here use raw values to avoid context dependency.
    return baseStyle;
  }
}
