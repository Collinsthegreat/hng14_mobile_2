import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';

/// A custom Material 3 text field widget for consistent form inputs.
///
/// This widget provides a reusable text field with customizable label, hint,
/// prefix/suffix icons, validation, and input formatting. It follows Material 3
/// design guidelines and uses the app's color scheme and typography.
///
/// Example usage:
/// ```dart
/// CustomTextField(
///   label: 'Title',
///   hint: 'Enter transaction title',
///   controller: _titleController,
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
class CustomTextField extends StatelessWidget {
  /// The text editing controller for this field.
  final TextEditingController? controller;

  /// The label text displayed above the field.
  final String? label;

  /// The hint text displayed inside the field when empty.
  final String? hint;

  /// Optional prefix icon displayed at the start of the field.
  final IconData? prefixIcon;

  /// Optional suffix icon displayed at the end of the field.
  final IconData? suffixIcon;

  /// Optional suffix widget (takes precedence over suffixIcon).
  final Widget? suffix;

  /// Callback when the suffix icon is tapped.
  final VoidCallback? onSuffixTap;

  /// The keyboard type for this field.
  ///
  /// Defaults to [TextInputType.text].
  final TextInputType keyboardType;

  /// Whether to obscure the text (for passwords).
  ///
  /// Defaults to false.
  final bool obscureText;

  /// Whether the field is read-only.
  ///
  /// Defaults to false.
  final bool readOnly;

  /// Whether the field is enabled.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Maximum number of lines for the field.
  ///
  /// Defaults to 1. Set to null for unlimited lines.
  final int? maxLines;

  /// Minimum number of lines for the field.
  ///
  /// Defaults to 1.
  final int minLines;

  /// Maximum length of text input.
  final int? maxLength;

  /// List of input formatters to apply.
  final List<TextInputFormatter>? inputFormatters;

  /// Validation function for form validation.
  final String? Function(String?)? validator;

  /// Callback when the field value changes.
  final void Function(String)? onChanged;

  /// Callback when the field is submitted.
  final void Function(String)? onSubmitted;

  /// Callback when the field is tapped.
  final VoidCallback? onTap;

  /// The text input action button.
  ///
  /// Defaults to [TextInputAction.done].
  final TextInputAction textInputAction;

  /// The text capitalization behavior.
  ///
  /// Defaults to [TextCapitalization.none].
  final TextCapitalization textCapitalization;

  /// Optional error text to display.
  final String? errorText;

  /// Optional helper text to display below the field.
  final String? helperText;

  /// Creates a custom text field.
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.errorText,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.labelLarge.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Text field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          style: AppTypography.bodyLarge.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            // Hint text
            hintText: hint,
            hintStyle: AppTypography.bodyLarge.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),

            // Helper text
            helperText: helperText,
            helperStyle: AppTypography.bodySmall.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),

            // Error text
            errorText: errorText,
            errorStyle: AppTypography.bodySmall.copyWith(
              color: AppColors.error,
            ),

            // Prefix icon
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  )
                : null,

            // Suffix icon or widget
            suffixIcon:
                suffix ??
                (suffixIcon != null
                    ? IconButton(
                        icon: Icon(
                          suffixIcon,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        onPressed: onSuffixTap,
                      )
                    : null),

            // Border styling
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,

            // Enabled border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                width: 1,
              ),
            ),

            // Focused border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),

            // Error border
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),

            // Focused error border
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),

            // Disabled border
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.greyDark : AppColors.greyLight,
                width: 1,
              ),
            ),

            // Content padding
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),

            // Counter style (for maxLength)
            counterStyle: AppTypography.bodySmall.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
      ],
    );
  }
}
