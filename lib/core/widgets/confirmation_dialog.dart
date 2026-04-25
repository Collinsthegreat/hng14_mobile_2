import 'package:flutter/material.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';
import 'package:expense_tracker/core/constants/app_strings.dart';

/// A custom Material 3 confirmation dialog widget.
///
/// This widget provides a reusable confirmation dialog with customizable title,
/// message, and action buttons. It follows Material 3 design guidelines and
/// uses the app's color scheme and typography.
///
/// Example usage:
/// ```dart
/// final confirmed = await showConfirmationDialog(
///   context: context,
///   title: 'Delete Transaction',
///   message: 'Are you sure you want to delete this transaction?',
///   confirmText: 'Delete',
///   isDangerous: true,
/// );
///
/// if (confirmed == true) {
///   // Perform delete action
/// }
/// ```
class ConfirmationDialog extends StatelessWidget {
  /// The title of the dialog.
  final String title;

  /// The message/content of the dialog.
  final String message;

  /// The text for the confirm button.
  ///
  /// Defaults to 'Confirm'.
  final String confirmText;

  /// The text for the cancel button.
  ///
  /// Defaults to 'Cancel'.
  final String cancelText;

  /// Whether this is a dangerous/destructive action.
  ///
  /// If true, the confirm button will be styled with error color.
  /// Defaults to false.
  final bool isDangerous;

  /// Optional icon to display at the top of the dialog.
  final IconData? icon;

  /// Creates a confirmation dialog.
  ///
  /// The [title] and [message] parameters are required.
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = AppStrings.confirm,
    this.cancelText = AppStrings.cancel,
    this.isDangerous = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon (if provided)
            if (icon != null) ...[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: (isDangerous ? AppColors.error : AppColors.primary)
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: isDangerous ? AppColors.error : AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Title
            Text(
              title,
              style: AppTypography.headlineSmall.copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message,
              style: AppTypography.bodyLarge.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                // Cancel button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      side: BorderSide(
                        color: isDark
                            ? AppColors.dividerDark
                            : AppColors.dividerLight,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(cancelText, style: AppTypography.buttonText),
                  ),
                ),

                const SizedBox(width: 12),

                // Confirm button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDangerous
                          ? AppColors.error
                          : AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      confirmText,
                      style: AppTypography.buttonText.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows a confirmation dialog and returns the user's choice.
///
/// Returns `true` if the user confirms, `false` if they cancel,
/// or `null` if they dismiss the dialog.
///
/// Example usage:
/// ```dart
/// final confirmed = await showConfirmationDialog(
///   context: context,
///   title: 'Delete Transaction',
///   message: 'Are you sure you want to delete this transaction?',
///   confirmText: 'Delete',
///   isDangerous: true,
/// );
///
/// if (confirmed == true) {
///   // Perform delete action
/// }
/// ```
Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmText = AppStrings.confirm,
  String cancelText = AppStrings.cancel,
  bool isDangerous = false,
  IconData? icon,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => ConfirmationDialog(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      isDangerous: isDangerous,
      icon: icon,
    ),
  );
}
