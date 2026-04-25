import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'app_categories.g.dart';

/// Transaction category definitions with associated metadata.
///
/// This file contains the TransactionCategory enum and provides metadata
/// for each category including icons, colors, and display names.
/// Categories are used to classify transactions for budgeting and analytics.

/// Enum representing all available transaction categories.
///
/// Categories are used to classify both income and expense transactions.
/// Each category has associated metadata (icon, color, display name).
@HiveType(typeId: 3)
enum TransactionCategory {
  // Expense categories
  @HiveField(0)
  food,
  @HiveField(1)
  transport,
  @HiveField(2)
  shopping,
  @HiveField(3)
  health,
  @HiveField(4)
  entertainment,
  @HiveField(5)
  education,
  @HiveField(6)
  rent,
  @HiveField(7)
  utilities,
  @HiveField(8)
  travel,

  // Income categories
  @HiveField(9)
  salary,
  @HiveField(10)
  freelance,
  @HiveField(11)
  investment,

  // General category
  @HiveField(12)
  other,
}

/// Extension on TransactionCategory to provide metadata for each category.
extension TransactionCategoryExtension on TransactionCategory {
  /// Returns the display name for the category.
  ///
  /// This is the user-facing text shown in the UI.
  String get displayName {
    switch (this) {
      case TransactionCategory.food:
        return 'Food';
      case TransactionCategory.transport:
        return 'Transport';
      case TransactionCategory.shopping:
        return 'Shopping';
      case TransactionCategory.health:
        return 'Health';
      case TransactionCategory.entertainment:
        return 'Entertainment';
      case TransactionCategory.education:
        return 'Education';
      case TransactionCategory.salary:
        return 'Salary';
      case TransactionCategory.freelance:
        return 'Freelance';
      case TransactionCategory.investment:
        return 'Investment';
      case TransactionCategory.rent:
        return 'Rent';
      case TransactionCategory.utilities:
        return 'Utilities';
      case TransactionCategory.travel:
        return 'Travel';
      case TransactionCategory.other:
        return 'Other';
    }
  }

  /// Returns the icon data for the category.
  ///
  /// Icons are from Material Icons and represent the category visually.
  IconData get icon {
    switch (this) {
      case TransactionCategory.food:
        return Icons.restaurant;
      case TransactionCategory.transport:
        return Icons.directions_car;
      case TransactionCategory.shopping:
        return Icons.shopping_bag;
      case TransactionCategory.health:
        return Icons.local_hospital;
      case TransactionCategory.entertainment:
        return Icons.movie;
      case TransactionCategory.education:
        return Icons.school;
      case TransactionCategory.salary:
        return Icons.account_balance_wallet;
      case TransactionCategory.freelance:
        return Icons.work;
      case TransactionCategory.investment:
        return Icons.trending_up;
      case TransactionCategory.rent:
        return Icons.home;
      case TransactionCategory.utilities:
        return Icons.bolt;
      case TransactionCategory.travel:
        return Icons.flight;
      case TransactionCategory.other:
        return Icons.more_horiz;
    }
  }

  /// Returns the color associated with the category.
  ///
  /// Colors help users quickly identify categories in the UI.
  /// Each category has a distinct color for visual differentiation.
  Color get color {
    switch (this) {
      case TransactionCategory.food:
        return const Color(0xFFFF6B6B); // Red
      case TransactionCategory.transport:
        return const Color(0xFF4ECDC4); // Teal
      case TransactionCategory.shopping:
        return const Color(0xFFFFBE0B); // Yellow
      case TransactionCategory.health:
        return const Color(0xFFFF006E); // Pink
      case TransactionCategory.entertainment:
        return const Color(0xFF8338EC); // Purple
      case TransactionCategory.education:
        return const Color(0xFF3A86FF); // Blue
      case TransactionCategory.salary:
        return const Color(0xFF06FFA5); // Green
      case TransactionCategory.freelance:
        return const Color(0xFF00BBF9); // Light Blue
      case TransactionCategory.investment:
        return const Color(0xFF2EC4B6); // Turquoise
      case TransactionCategory.rent:
        return const Color(0xFFFF9F1C); // Orange
      case TransactionCategory.utilities:
        return const Color(0xFFFBF8CC); // Light Yellow
      case TransactionCategory.travel:
        return const Color(0xFF5E60CE); // Indigo
      case TransactionCategory.other:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  /// Returns whether this category is typically used for income transactions.
  ///
  /// Returns true for salary, freelance, and investment categories.
  bool get isIncomeCategory {
    return this == TransactionCategory.salary ||
        this == TransactionCategory.freelance ||
        this == TransactionCategory.investment;
  }

  /// Returns whether this category is typically used for expense transactions.
  ///
  /// Returns true for all categories except income categories.
  bool get isExpenseCategory {
    return !isIncomeCategory;
  }
}

/// Helper class for working with transaction categories.
class CategoryHelper {
  // Private constructor to prevent instantiation
  CategoryHelper._();

  /// Returns all available transaction categories.
  static List<TransactionCategory> get allCategories {
    return TransactionCategory.values;
  }

  /// Returns only income-related categories.
  static List<TransactionCategory> get incomeCategories {
    return TransactionCategory.values
        .where((category) => category.isIncomeCategory)
        .toList();
  }

  /// Returns only expense-related categories.
  static List<TransactionCategory> get expenseCategories {
    return TransactionCategory.values
        .where((category) => category.isExpenseCategory)
        .toList();
  }

  /// Finds a category by its display name.
  ///
  /// Returns null if no matching category is found.
  /// The comparison is case-insensitive.
  static TransactionCategory? findByDisplayName(String displayName) {
    try {
      return TransactionCategory.values.firstWhere(
        (category) =>
            category.displayName.toLowerCase() == displayName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Finds a category by its enum name.
  ///
  /// Returns null if no matching category is found.
  /// The comparison is case-insensitive.
  static TransactionCategory? findByName(String name) {
    try {
      return TransactionCategory.values.firstWhere(
        (category) => category.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Returns a map of category to its metadata for easy lookup.
  static Map<TransactionCategory, CategoryMetadata> get categoryMetadataMap {
    return {
      for (var category in TransactionCategory.values)
        category: CategoryMetadata(
          category: category,
          displayName: category.displayName,
          icon: category.icon,
          color: category.color,
          isIncomeCategory: category.isIncomeCategory,
        ),
    };
  }
}

/// Data class representing category metadata.
///
/// This class encapsulates all metadata associated with a transaction category.
class CategoryMetadata {
  /// The transaction category enum value.
  final TransactionCategory category;

  /// The user-facing display name.
  final String displayName;

  /// The Material icon representing the category.
  final IconData icon;

  /// The color associated with the category.
  final Color color;

  /// Whether this category is typically used for income.
  final bool isIncomeCategory;

  /// Creates a CategoryMetadata instance.
  const CategoryMetadata({
    required this.category,
    required this.displayName,
    required this.icon,
    required this.color,
    required this.isIncomeCategory,
  });

  /// Whether this category is typically used for expenses.
  bool get isExpenseCategory => !isIncomeCategory;

  @override
  String toString() {
    return 'CategoryMetadata(category: $category, displayName: $displayName, '
        'isIncomeCategory: $isIncomeCategory)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryMetadata &&
        other.category == category &&
        other.displayName == displayName &&
        other.icon == icon &&
        other.color == color &&
        other.isIncomeCategory == isIncomeCategory;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        displayName.hashCode ^
        icon.hashCode ^
        color.hashCode ^
        isIncomeCategory.hashCode;
  }
}
