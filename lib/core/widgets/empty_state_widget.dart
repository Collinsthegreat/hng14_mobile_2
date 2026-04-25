import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';
import 'package:expense_tracker/core/constants/app_constants.dart';

/// A widget that displays an empty state with a Lottie animation.
///
/// This widget is used to show a friendly empty state when there's no data
/// to display. It includes a Lottie animation, title, message, and optional
/// action button.
///
/// Example usage:
/// ```dart
/// EmptyStateWidget(
///   title: 'No Transactions Yet',
///   message: 'Start tracking your finances by adding your first transaction',
///   actionText: 'Add Transaction',
///   onActionPressed: () => context.go('/transactions/add'),
/// )
/// ```
class EmptyStateWidget extends StatelessWidget {
  /// The title text to display.
  final String title;

  /// The message text to display below the title.
  final String message;

  /// Optional action button text.
  ///
  /// If provided, an action button will be displayed.
  final String? actionText;

  /// Callback when the action button is pressed.
  ///
  /// Required if [actionText] is provided.
  final VoidCallback? onActionPressed;

  /// Optional custom Lottie animation asset path.
  ///
  /// If not provided, uses the default empty state animation.
  final String? animationAsset;

  /// The size of the Lottie animation.
  ///
  /// Defaults to 200.
  final double animationSize;

  /// Creates an empty state widget.
  ///
  /// The [title] and [message] parameters are required.
  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.actionText,
    this.onActionPressed,
    this.animationAsset,
    this.animationSize = 200,
  }) : assert(
         actionText == null || onActionPressed != null,
         'onActionPressed must be provided when actionText is not null',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie animation
            SizedBox(
              width: animationSize,
              height: animationSize,
              child: Lottie.asset(
                animationAsset ?? AppConstants.emptyStateAnimation,
                fit: BoxFit.contain,
                repeat: true,
                animate: true,
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: AppTypography.headlineMedium.copyWith(
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

            // Action button
            if (actionText != null && onActionPressed != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onActionPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  actionText!,
                  style: AppTypography.buttonText.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
