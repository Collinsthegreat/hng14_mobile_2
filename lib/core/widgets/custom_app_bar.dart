import 'package:flutter/material.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';

/// A custom Material 3 app bar widget for consistent styling across the app.
///
/// This widget provides a reusable app bar with customizable title, actions,
/// and optional leading widget. It follows Material 3 design guidelines and
/// uses the app's color scheme and typography.
///
/// Example usage:
/// ```dart
/// CustomAppBar(
///   title: 'Dashboard',
///   actions: [
///     IconButton(
///       icon: Icon(Icons.settings),
///       onPressed: () => context.go('/settings'),
///     ),
///   ],
/// )
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text to display in the app bar.
  final String title;

  /// Optional list of action widgets to display on the right side.
  final List<Widget>? actions;

  /// Optional leading widget (typically a back button or menu icon).
  ///
  /// If null and [automaticallyImplyLeading] is true, a back button
  /// will be shown automatically when there's a previous route.
  final Widget? leading;

  /// Whether to automatically show a back button when applicable.
  ///
  /// Defaults to true.
  final bool automaticallyImplyLeading;

  /// Whether to center the title text.
  ///
  /// Defaults to false (title aligned to the left).
  final bool centerTitle;

  /// Optional background color for the app bar.
  ///
  /// If null, uses the theme's primary color.
  final Color? backgroundColor;

  /// Optional elevation for the app bar shadow.
  ///
  /// Defaults to 0 for a flat appearance (Material 3 style).
  final double elevation;

  /// Creates a custom app bar.
  ///
  /// The [title] parameter is required.
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      // Title
      title: Text(
        title,
        style: AppTypography.titleLarge.copyWith(
          color: isDark
              ? AppColors.textPrimaryDark
              : AppColors.textPrimaryLight,
        ),
      ),

      // Leading widget
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,

      // Actions
      actions: actions,

      // Styling
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor:
          backgroundColor ??
          (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),

      // Icon theme for leading and action icons
      iconTheme: IconThemeData(
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      ),

      // Action icon theme
      actionsIconTheme: IconThemeData(
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      ),

      // Surface tint color for Material 3
      surfaceTintColor: Colors.transparent,

      // Scroll under elevation behavior
      scrolledUnderElevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
