import 'package:flutter/material.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';

/// Button style variants for different use cases.
enum ButtonVariant {
  /// Filled button with solid background color (primary action).
  primary,

  /// Outlined button with border (secondary action).
  secondary,

  /// Text button without background (tertiary action).
  text,

  /// Filled button with error/danger color.
  danger,
}

/// Button size variants.
enum ButtonSize {
  /// Small button (height: 36).
  small,

  /// Medium button (height: 48) - default.
  medium,

  /// Large button (height: 56).
  large,
}

/// A custom Material 3 button widget with multiple variants and sizes.
///
/// This widget provides a reusable button with consistent styling across the app.
/// It supports different variants (primary, secondary, text, danger) and sizes
/// (small, medium, large).
///
/// Example usage:
/// ```dart
/// CustomButton(
///   text: 'Save Transaction',
///   onPressed: () => _saveTransaction(),
///   variant: ButtonVariant.primary,
///   size: ButtonSize.large,
/// )
/// ```
class CustomButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// Callback function when the button is pressed.
  ///
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The button style variant.
  ///
  /// Defaults to [ButtonVariant.primary].
  final ButtonVariant variant;

  /// The button size.
  ///
  /// Defaults to [ButtonSize.medium].
  final ButtonSize size;

  /// Optional icon to display before the text.
  final IconData? icon;

  /// Whether the button should take full width of its parent.
  ///
  /// Defaults to false.
  final bool fullWidth;

  /// Whether the button is in a loading state.
  ///
  /// When true, shows a loading indicator and disables the button.
  /// Defaults to false.
  final bool isLoading;

  /// Creates a custom button.
  ///
  /// The [text] parameter is required.
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine button height based on size
    final double height = switch (size) {
      ButtonSize.small => 36,
      ButtonSize.medium => 48,
      ButtonSize.large => 56,
    };

    // Determine if button should be disabled
    final bool isDisabled = onPressed == null || isLoading;

    // Build button content
    final Widget content = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getTextColor(isDark, isDisabled),
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: AppTypography.buttonText.copyWith(
                  color: _getTextColor(isDark, isDisabled),
                ),
              ),
            ],
          );

    // Build button based on variant
    final Widget button = switch (variant) {
      ButtonVariant.primary => _buildPrimaryButton(
        context,
        content,
        height,
        isDisabled,
        isDark,
      ),
      ButtonVariant.secondary => _buildSecondaryButton(
        context,
        content,
        height,
        isDisabled,
        isDark,
      ),
      ButtonVariant.text => _buildTextButton(
        context,
        content,
        height,
        isDisabled,
        isDark,
      ),
      ButtonVariant.danger => _buildDangerButton(
        context,
        content,
        height,
        isDisabled,
        isDark,
      ),
    };

    // Wrap in SizedBox for full width if needed
    if (fullWidth) {
      return SizedBox(width: double.infinity, height: height, child: button);
    }

    return SizedBox(height: height, child: button);
  }

  /// Builds a primary filled button.
  Widget _buildPrimaryButton(
    BuildContext context,
    Widget content,
    double height,
    bool isDisabled,
    bool isDark,
  ) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? (isDark ? AppColors.greyDark : AppColors.greyLight)
            : AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: content,
    );
  }

  /// Builds a secondary outlined button.
  Widget _buildSecondaryButton(
    BuildContext context,
    Widget content,
    double height,
    bool isDisabled,
    bool isDark,
  ) {
    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: isDisabled
            ? (isDark ? AppColors.greyDark : AppColors.greyLight)
            : AppColors.primary,
        side: BorderSide(
          color: isDisabled
              ? (isDark ? AppColors.greyDark : AppColors.greyLight)
              : AppColors.primary,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: content,
    );
  }

  /// Builds a text button.
  Widget _buildTextButton(
    BuildContext context,
    Widget content,
    double height,
    bool isDisabled,
    bool isDark,
  ) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: isDisabled
            ? (isDark ? AppColors.greyDark : AppColors.greyLight)
            : AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: content,
    );
  }

  /// Builds a danger/error button.
  Widget _buildDangerButton(
    BuildContext context,
    Widget content,
    double height,
    bool isDisabled,
    bool isDark,
  ) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? (isDark ? AppColors.greyDark : AppColors.greyLight)
            : AppColors.error,
        foregroundColor: AppColors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: content,
    );
  }

  /// Gets the appropriate text color based on variant and state.
  Color _getTextColor(bool isDark, bool isDisabled) {
    if (isDisabled) {
      return isDark ? AppColors.greyDark : AppColors.greyLight;
    }

    return switch (variant) {
      ButtonVariant.primary => AppColors.white,
      ButtonVariant.secondary => AppColors.primary,
      ButtonVariant.text => AppColors.primary,
      ButtonVariant.danger => AppColors.white,
    };
  }
}
