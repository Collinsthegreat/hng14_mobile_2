import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';
import 'package:expense_tracker/core/constants/app_constants.dart';
import 'package:expense_tracker/core/constants/app_strings.dart';

/// A widget that displays a loading state with a Lottie animation.
///
/// This widget is used to show a loading indicator when data is being fetched
/// or processed. It includes a Lottie animation and optional loading message.
///
/// Example usage:
/// ```dart
/// LoadingWidget(
///   message: 'Loading transactions...',
/// )
/// ```
class LoadingWidget extends StatelessWidget {
  /// Optional loading message to display below the animation.
  final String? message;

  /// Optional custom Lottie animation asset path.
  ///
  /// If not provided, uses the default loading animation.
  final String? animationAsset;

  /// The size of the Lottie animation.
  ///
  /// Defaults to 150.
  final double animationSize;

  /// Whether to use a circular progress indicator instead of Lottie.
  ///
  /// Defaults to false. Set to true for a simple loading indicator.
  final bool useSimpleIndicator;

  /// Creates a loading widget.
  const LoadingWidget({
    super.key,
    this.message,
    this.animationAsset,
    this.animationSize = 150,
    this.useSimpleIndicator = false,
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
            // Loading indicator
            if (useSimpleIndicator)
              const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              )
            else
              SizedBox(
                width: animationSize,
                height: animationSize,
                child: Lottie.asset(
                  animationAsset ?? AppConstants.loadingAnimation,
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                ),
              ),

            const SizedBox(height: 24),

            // Loading message
            Text(
              message ?? AppStrings.loading,
              style: AppTypography.bodyLarge.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple circular loading indicator widget.
///
/// This is a minimal loading widget that displays only a circular progress
/// indicator without any text or animation.
///
/// Example usage:
/// ```dart
/// SimpleLoadingIndicator()
/// ```
class SimpleLoadingIndicator extends StatelessWidget {
  /// The size of the loading indicator.
  ///
  /// Defaults to 48.
  final double size;

  /// The stroke width of the circular indicator.
  ///
  /// Defaults to 3.
  final double strokeWidth;

  /// The color of the loading indicator.
  ///
  /// Defaults to [AppColors.primary].
  final Color? color;

  /// Creates a simple loading indicator.
  const SimpleLoadingIndicator({
    super.key,
    this.size = 48,
    this.strokeWidth = 3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
        ),
      ),
    );
  }
}

/// A loading overlay widget that can be placed on top of other widgets.
///
/// This widget displays a semi-transparent overlay with a loading indicator
/// in the center. Useful for showing loading state while keeping the UI visible.
///
/// Example usage:
/// ```dart
/// Stack(
///   children: [
///     MyContent(),
///     if (isLoading) LoadingOverlay(),
///   ],
/// )
/// ```
class LoadingOverlay extends StatelessWidget {
  /// Optional loading message to display.
  final String? message;

  /// The opacity of the overlay background.
  ///
  /// Defaults to 0.5 (50% opacity).
  final double opacity;

  /// Whether to use a simple circular indicator.
  ///
  /// Defaults to true for overlays.
  final bool useSimpleIndicator;

  /// Creates a loading overlay.
  const LoadingOverlay({
    super.key,
    this.message,
    this.opacity = 0.5,
    this.useSimpleIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: (isDark ? AppColors.black : AppColors.white).withValues(
        alpha: opacity,
      ),
      child: LoadingWidget(
        message: message,
        useSimpleIndicator: useSimpleIndicator,
      ),
    );
  }
}
