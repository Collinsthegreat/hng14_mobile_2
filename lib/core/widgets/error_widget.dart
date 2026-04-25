import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';
import 'package:expense_tracker/core/constants/app_constants.dart';
import 'package:expense_tracker/core/constants/app_strings.dart';

/// A widget that displays an error state with a Lottie animation and retry button.
///
/// This widget is used to show a friendly error state when something goes wrong.
/// It includes a Lottie animation, error message, and a retry button.
///
/// Example usage:
/// ```dart
/// CustomErrorWidget(
///   message: 'Failed to load transactions',
///   onRetry: () => _loadTransactions(),
/// )
/// ```
class CustomErrorWidget extends StatelessWidget {
  /// The error message to display.
  final String message;

  /// Callback when the retry button is pressed.
  final VoidCallback onRetry;

  /// Optional custom Lottie animation asset path.
  ///
  /// If not provided, uses the default error state animation.
  final String? animationAsset;

  /// The size of the Lottie animation.
  ///
  /// Defaults to 200.
  final double animationSize;

  /// Optional custom retry button text.
  ///
  /// Defaults to 'Retry'.
  final String? retryText;

  /// Creates an error widget.
  ///
  /// The [message] and [onRetry] parameters are required.
  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.animationAsset,
    this.animationSize = 200,
    this.retryText,
  });

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
                animationAsset ?? AppConstants.errorStateAnimation,
                fit: BoxFit.contain,
                repeat: true,
                animate: true,
              ),
            ),

            const SizedBox(height: 24),

            // Error title
            Text(
              AppStrings.error,
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Error message
            Text(
              message,
              style: AppTypography.bodyLarge.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Retry button
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                retryText ?? AppStrings.retry,
                style: AppTypography.buttonText.copyWith(
                  color: AppColors.white,
                ),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
