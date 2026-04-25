import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Application theme configuration using FlexColorScheme.
///
/// This file defines both light and dark themes for the app using
/// FlexColorScheme for Material 3 support. The themes are configured
/// with custom colors from AppColors and use Google Fonts Inter for typography.
///
/// The themes follow Material Design 3 guidelines and provide:
/// - Consistent color schemes across light and dark modes
/// - Proper surface elevation and blending
/// - Semantic color usage for income, expense, and warnings
/// - Custom typography using Inter font family
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ============================================================================
  // Light Theme
  // ============================================================================

  /// Light theme configuration using FlexColorScheme.
  ///
  /// Features:
  /// - Deep Indigo primary color (#3D5AFE)
  /// - Teal secondary color (#00BCD4)
  /// - High scaffold, low surface blending for depth
  /// - Primary app bar style for brand consistency
  /// - Inter font family from Google Fonts
  static ThemeData get lightTheme {
    return FlexThemeData.light(
      // Color Configuration
      colors: const FlexSchemeColor(
        primary: AppColors.primary,
        primaryContainer: Color(0xFFD1D9FF),
        secondary: AppColors.secondary,
        secondaryContainer: Color(0xFFB2EBF2),
        tertiary: Color(0xFF6200EA),
        tertiaryContainer: Color(0xFFE1BEE7),
        appBarColor: AppColors.primary,
        error: AppColors.error,
      ),

      // Surface and Blend Configuration
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 9,

      // App Bar Configuration
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 1.0,
      appBarElevation: 0,

      // Tab Bar Configuration
      tabBarStyle: FlexTabBarStyle.forAppBar,

      // Tooltip Configuration
      tooltipsMatchBackground: true,

      // Visual Density
      visualDensity: FlexColorScheme.comfortablePlatformDensity,

      // Typography
      fontFamily: GoogleFonts.inter().fontFamily,

      // Material 3 Configuration
      useMaterial3: true,
      swapLegacyOnMaterial3: true,

      // Sub-themes Configuration
      subThemesData: const FlexSubThemesData(
        // General
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        defaultRadius: 12.0,
        thinBorderWidth: 1.0,
        thickBorderWidth: 2.0,

        // Interaction Effects
        interactionEffects: true,
        tintedDisabledControls: true,

        // Button Configuration
        elevatedButtonSchemeColor: SchemeColor.primary,
        elevatedButtonSecondarySchemeColor: SchemeColor.onPrimary,
        filledButtonSchemeColor: SchemeColor.primary,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        textButtonSchemeColor: SchemeColor.primary,

        // Toggle Configuration
        switchSchemeColor: SchemeColor.primary,
        checkboxSchemeColor: SchemeColor.primary,
        radioSchemeColor: SchemeColor.primary,

        // Input Decoration
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: true,
        inputDecoratorFillColor: Color(0xFFF5F5F5),
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedHasBorder: true,
        inputDecoratorFocusedHasBorder: true,

        // Card Configuration
        cardElevation: 2.0,

        // Chip Configuration
        chipSchemeColor: SchemeColor.primary,
        chipSelectedSchemeColor: SchemeColor.primary,
        chipDeleteIconSchemeColor: SchemeColor.onPrimary,

        // Navigation Bar Configuration
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarSelectedIconSchemeColor: SchemeColor.primary,
        navigationBarIndicatorSchemeColor: SchemeColor.primaryContainer,
        navigationBarIndicatorOpacity: 0.24,
        navigationBarElevation: 0,
        navigationBarHeight: 62,

        // Bottom Navigation Bar Configuration
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarElevation: 3,

        // App Bar Configuration
        appBarScrolledUnderElevation: 4,

        // Bottom Sheet Configuration
        bottomSheetElevation: 4,
        bottomSheetModalElevation: 8,

        // Dialog Configuration
        dialogElevation: 6,
        dialogBackgroundSchemeColor: SchemeColor.surface,

        // Floating Action Button Configuration
        fabUseShape: true,
        fabSchemeColor: SchemeColor.primary,
      ),
    );
  }

  // ============================================================================
  // Dark Theme
  // ============================================================================

  /// Dark theme configuration using FlexColorScheme.
  ///
  /// Features:
  /// - Deep Indigo primary color (#3D5AFE)
  /// - Teal secondary color (#00BCD4)
  /// - High scaffold, low surface blending for depth
  /// - Background app bar style for dark mode aesthetics
  /// - Inter font family from Google Fonts
  /// - True black background for OLED displays
  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      // Color Configuration
      colors: const FlexSchemeColor(
        primary: AppColors.primary,
        primaryContainer: Color(0xFF1E3A8A),
        secondary: AppColors.secondary,
        secondaryContainer: Color(0xFF006064),
        tertiary: Color(0xFFBB86FC),
        tertiaryContainer: Color(0xFF4A148C),
        appBarColor: AppColors.surfaceDark,
        error: AppColors.error,
      ),

      // Surface and Blend Configuration
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 15,

      // App Bar Configuration
      appBarStyle: FlexAppBarStyle.background,
      appBarOpacity: 1.0,
      appBarElevation: 0,

      // Tab Bar Configuration
      tabBarStyle: FlexTabBarStyle.forAppBar,

      // Tooltip Configuration
      tooltipsMatchBackground: true,

      // Visual Density
      visualDensity: FlexColorScheme.comfortablePlatformDensity,

      // Typography
      fontFamily: GoogleFonts.inter().fontFamily,

      // Dark Mode Configuration
      darkIsTrueBlack: true, // Use true black for OLED displays
      // Material 3 Configuration
      useMaterial3: true,
      swapLegacyOnMaterial3: true,

      // Sub-themes Configuration
      subThemesData: const FlexSubThemesData(
        // General
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        defaultRadius: 12.0,
        thinBorderWidth: 1.0,
        thickBorderWidth: 2.0,

        // Interaction Effects
        interactionEffects: true,
        tintedDisabledControls: true,

        // Button Configuration
        elevatedButtonSchemeColor: SchemeColor.primary,
        elevatedButtonSecondarySchemeColor: SchemeColor.onPrimary,
        filledButtonSchemeColor: SchemeColor.primary,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        textButtonSchemeColor: SchemeColor.primary,

        // Toggle Configuration
        switchSchemeColor: SchemeColor.primary,
        checkboxSchemeColor: SchemeColor.primary,
        radioSchemeColor: SchemeColor.primary,

        // Input Decoration
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: true,
        inputDecoratorFillColor: Color(0xFF1E1E1E),
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedHasBorder: true,
        inputDecoratorFocusedHasBorder: true,

        // Card Configuration
        cardElevation: 2.0,

        // Chip Configuration
        chipSchemeColor: SchemeColor.primary,
        chipSelectedSchemeColor: SchemeColor.primary,
        chipDeleteIconSchemeColor: SchemeColor.onPrimary,

        // Navigation Bar Configuration
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarSelectedIconSchemeColor: SchemeColor.primary,
        navigationBarIndicatorSchemeColor: SchemeColor.primaryContainer,
        navigationBarIndicatorOpacity: 0.24,
        navigationBarElevation: 0,
        navigationBarHeight: 62,

        // Bottom Navigation Bar Configuration
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarElevation: 3,
        bottomNavigationBarBackgroundSchemeColor: SchemeColor.surface,

        // App Bar Configuration
        appBarScrolledUnderElevation: 4,

        // Bottom Sheet Configuration
        bottomSheetElevation: 4,
        bottomSheetModalElevation: 8,

        // Dialog Configuration
        dialogElevation: 6,
        dialogBackgroundSchemeColor: SchemeColor.surface,

        // Floating Action Button Configuration
        fabUseShape: true,
        fabSchemeColor: SchemeColor.primary,
      ),
    );
  }

  // ============================================================================
  // Theme Mode Helper
  // ============================================================================

  /// Returns the appropriate theme based on the theme mode.
  ///
  /// [themeMode] The desired theme mode (light, dark, or system).
  /// [brightness] The system brightness (used when themeMode is system).
  static ThemeData getTheme(ThemeMode themeMode, Brightness brightness) {
    if (themeMode == ThemeMode.light) {
      return lightTheme;
    } else if (themeMode == ThemeMode.dark) {
      return darkTheme;
    } else {
      // System mode - use system brightness
      return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }

  // ============================================================================
  // Custom Theme Extensions
  // ============================================================================

  /// Custom color extensions for semantic colors not covered by Material 3.
  ///
  /// These extensions provide easy access to app-specific colors like
  /// income, expense, and warning colors in both light and dark themes.
  static ThemeData applyCustomExtensions(ThemeData theme, bool isDark) {
    return theme.copyWith(
      extensions: [
        CustomColors(
          income: AppColors.income,
          expense: AppColors.expense,
          warning: AppColors.warning,
          success: AppColors.success,
          info: AppColors.info,
          budgetOnTrack: AppColors.budgetOnTrack,
          budgetWarning: AppColors.budgetWarning,
          budgetExceeded: AppColors.budgetExceeded,
        ),
      ],
    );
  }

  /// Get light theme with custom extensions.
  static ThemeData get lightThemeWithExtensions {
    return applyCustomExtensions(lightTheme, false);
  }

  /// Get dark theme with custom extensions.
  static ThemeData get darkThemeWithExtensions {
    return applyCustomExtensions(darkTheme, true);
  }
}

// ============================================================================
// Custom Theme Extension
// ============================================================================

/// Custom colors theme extension for app-specific semantic colors.
///
/// This extension provides access to colors that are specific to the
/// expense tracker app, such as income, expense, and budget status colors.
///
/// Usage:
/// ```dart
/// final customColors = Theme.of(context).extension<CustomColors>()!;
/// final incomeColor = customColors.income;
/// ```
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.income,
    required this.expense,
    required this.warning,
    required this.success,
    required this.info,
    required this.budgetOnTrack,
    required this.budgetWarning,
    required this.budgetExceeded,
  });

  final Color income;
  final Color expense;
  final Color warning;
  final Color success;
  final Color info;
  final Color budgetOnTrack;
  final Color budgetWarning;
  final Color budgetExceeded;

  @override
  CustomColors copyWith({
    Color? income,
    Color? expense,
    Color? warning,
    Color? success,
    Color? info,
    Color? budgetOnTrack,
    Color? budgetWarning,
    Color? budgetExceeded,
  }) {
    return CustomColors(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      info: info ?? this.info,
      budgetOnTrack: budgetOnTrack ?? this.budgetOnTrack,
      budgetWarning: budgetWarning ?? this.budgetWarning,
      budgetExceeded: budgetExceeded ?? this.budgetExceeded,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      success: Color.lerp(success, other.success, t)!,
      info: Color.lerp(info, other.info, t)!,
      budgetOnTrack: Color.lerp(budgetOnTrack, other.budgetOnTrack, t)!,
      budgetWarning: Color.lerp(budgetWarning, other.budgetWarning, t)!,
      budgetExceeded: Color.lerp(budgetExceeded, other.budgetExceeded, t)!,
    );
  }
}
