import 'package:flutter/material.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';

/// A custom Material 3 dropdown widget for consistent selection inputs.
///
/// This widget provides a reusable dropdown with customizable label, hint,
/// and items. It follows Material 3 design guidelines and uses the app's
/// color scheme and typography.
///
/// Example usage:
/// ```dart
/// CustomDropdown<String>(
///   label: 'Category',
///   hint: 'Select category',
///   value: selectedCategory,
///   items: categories,
///   onChanged: (value) => setState(() => selectedCategory = value),
///   itemBuilder: (category) => Text(category),
/// )
/// ```
class CustomDropdown<T> extends StatelessWidget {
  /// The currently selected value.
  final T? value;

  /// The list of items to display in the dropdown.
  final List<T> items;

  /// Callback when a new item is selected.
  final void Function(T?)? onChanged;

  /// Builder function to create the display widget for each item.
  final Widget Function(T) itemBuilder;

  /// The label text displayed above the dropdown.
  final String? label;

  /// The hint text displayed when no item is selected.
  final String? hint;

  /// Optional prefix icon displayed at the start of the dropdown.
  final IconData? prefixIcon;

  /// Whether the dropdown is enabled.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Optional error text to display.
  final String? errorText;

  /// Optional helper text to display below the dropdown.
  final String? helperText;

  /// Validation function for form validation.
  final String? Function(T?)? validator;

  /// Creates a custom dropdown.
  ///
  /// The [items] and [itemBuilder] parameters are required.
  const CustomDropdown({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.validator,
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

        // Dropdown field
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(value: item, child: itemBuilder(item));
          }).toList(),
          onChanged: enabled ? onChanged : null,
          validator: validator,
          style: AppTypography.bodyLarge.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
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
          ),

          // Dropdown menu styling
          dropdownColor: isDark
              ? AppColors.surfaceDark
              : AppColors.surfaceLight,

          // Border radius for dropdown menu
          borderRadius: BorderRadius.circular(12),

          // Elevation for dropdown menu
          elevation: 8,

          // Menu max height
          menuMaxHeight: 300,

          // Alignment
          alignment: AlignmentDirectional.centerStart,
        ),
      ],
    );
  }
}
