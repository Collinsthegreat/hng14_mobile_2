import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/core/constants/app_categories.dart';

void main() {
  group('TransactionCategory', () {
    test('should have all 13 required categories', () {
      expect(TransactionCategory.values.length, 13);
      expect(TransactionCategory.values, contains(TransactionCategory.food));
      expect(
        TransactionCategory.values,
        contains(TransactionCategory.transport),
      );
      expect(
        TransactionCategory.values,
        contains(TransactionCategory.shopping),
      );
      expect(TransactionCategory.values, contains(TransactionCategory.health));
      expect(
        TransactionCategory.values,
        contains(TransactionCategory.entertainment),
      );
      expect(
        TransactionCategory.values,
        contains(TransactionCategory.education),
      );
      expect(TransactionCategory.values, contains(TransactionCategory.salary));
      expect(
        TransactionCategory.values,
        contains(TransactionCategory.freelance),
      );
      expect(
        TransactionCategory.values,
        contains(TransactionCategory.investment),
      );
      expect(TransactionCategory.values, contains(TransactionCategory.rent));
      expect(
        TransactionCategory.values,
        contains(TransactionCategory.utilities),
      );
      expect(TransactionCategory.values, contains(TransactionCategory.travel));
      expect(TransactionCategory.values, contains(TransactionCategory.other));
    });
  });

  group('TransactionCategoryExtension', () {
    test('displayName should return correct names', () {
      expect(TransactionCategory.food.displayName, 'Food');
      expect(TransactionCategory.transport.displayName, 'Transport');
      expect(TransactionCategory.shopping.displayName, 'Shopping');
      expect(TransactionCategory.health.displayName, 'Health');
      expect(TransactionCategory.entertainment.displayName, 'Entertainment');
      expect(TransactionCategory.education.displayName, 'Education');
      expect(TransactionCategory.salary.displayName, 'Salary');
      expect(TransactionCategory.freelance.displayName, 'Freelance');
      expect(TransactionCategory.investment.displayName, 'Investment');
      expect(TransactionCategory.rent.displayName, 'Rent');
      expect(TransactionCategory.utilities.displayName, 'Utilities');
      expect(TransactionCategory.travel.displayName, 'Travel');
      expect(TransactionCategory.other.displayName, 'Other');
    });

    test('icon should return valid IconData for all categories', () {
      for (var category in TransactionCategory.values) {
        expect(category.icon, isA<IconData>());
      }
    });

    test('color should return valid Color for all categories', () {
      for (var category in TransactionCategory.values) {
        expect(category.color, isA<Color>());
      }
    });

    test('isIncomeCategory should return true for income categories', () {
      expect(TransactionCategory.salary.isIncomeCategory, true);
      expect(TransactionCategory.freelance.isIncomeCategory, true);
      expect(TransactionCategory.investment.isIncomeCategory, true);
    });

    test('isIncomeCategory should return false for expense categories', () {
      expect(TransactionCategory.food.isIncomeCategory, false);
      expect(TransactionCategory.transport.isIncomeCategory, false);
      expect(TransactionCategory.shopping.isIncomeCategory, false);
      expect(TransactionCategory.health.isIncomeCategory, false);
      expect(TransactionCategory.entertainment.isIncomeCategory, false);
      expect(TransactionCategory.education.isIncomeCategory, false);
      expect(TransactionCategory.rent.isIncomeCategory, false);
      expect(TransactionCategory.utilities.isIncomeCategory, false);
      expect(TransactionCategory.travel.isIncomeCategory, false);
      expect(TransactionCategory.other.isIncomeCategory, false);
    });

    test('isExpenseCategory should return true for expense categories', () {
      expect(TransactionCategory.food.isExpenseCategory, true);
      expect(TransactionCategory.transport.isExpenseCategory, true);
      expect(TransactionCategory.shopping.isExpenseCategory, true);
    });

    test('isExpenseCategory should return false for income categories', () {
      expect(TransactionCategory.salary.isExpenseCategory, false);
      expect(TransactionCategory.freelance.isExpenseCategory, false);
      expect(TransactionCategory.investment.isExpenseCategory, false);
    });
  });

  group('CategoryHelper', () {
    test('allCategories should return all 13 categories', () {
      expect(CategoryHelper.allCategories.length, 13);
    });

    test('incomeCategories should return only income categories', () {
      final incomeCategories = CategoryHelper.incomeCategories;
      expect(incomeCategories.length, 3);
      expect(incomeCategories, contains(TransactionCategory.salary));
      expect(incomeCategories, contains(TransactionCategory.freelance));
      expect(incomeCategories, contains(TransactionCategory.investment));
    });

    test('expenseCategories should return only expense categories', () {
      final expenseCategories = CategoryHelper.expenseCategories;
      expect(expenseCategories.length, 10);
      expect(expenseCategories, contains(TransactionCategory.food));
      expect(expenseCategories, contains(TransactionCategory.transport));
      expect(expenseCategories, contains(TransactionCategory.shopping));
      expect(expenseCategories, contains(TransactionCategory.health));
      expect(expenseCategories, contains(TransactionCategory.entertainment));
      expect(expenseCategories, contains(TransactionCategory.education));
      expect(expenseCategories, contains(TransactionCategory.rent));
      expect(expenseCategories, contains(TransactionCategory.utilities));
      expect(expenseCategories, contains(TransactionCategory.travel));
      expect(expenseCategories, contains(TransactionCategory.other));
    });

    test('findByDisplayName should find category by display name', () {
      expect(
        CategoryHelper.findByDisplayName('Food'),
        TransactionCategory.food,
      );
      expect(
        CategoryHelper.findByDisplayName('food'),
        TransactionCategory.food,
      );
      expect(
        CategoryHelper.findByDisplayName('FOOD'),
        TransactionCategory.food,
      );
    });

    test('findByDisplayName should return null for invalid name', () {
      expect(CategoryHelper.findByDisplayName('Invalid'), null);
    });

    test('findByName should find category by enum name', () {
      expect(CategoryHelper.findByName('food'), TransactionCategory.food);
      expect(CategoryHelper.findByName('FOOD'), TransactionCategory.food);
      expect(CategoryHelper.findByName('salary'), TransactionCategory.salary);
    });

    test('findByName should return null for invalid name', () {
      expect(CategoryHelper.findByName('invalid'), null);
    });

    test('categoryMetadataMap should contain all categories', () {
      final metadataMap = CategoryHelper.categoryMetadataMap;
      expect(metadataMap.length, 13);
      expect(metadataMap.keys, containsAll(TransactionCategory.values));
    });
  });

  group('CategoryMetadata', () {
    test('should create metadata with all properties', () {
      const metadata = CategoryMetadata(
        category: TransactionCategory.food,
        displayName: 'Food',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B6B),
        isIncomeCategory: false,
      );

      expect(metadata.category, TransactionCategory.food);
      expect(metadata.displayName, 'Food');
      expect(metadata.icon, Icons.restaurant);
      expect(metadata.color, const Color(0xFFFF6B6B));
      expect(metadata.isIncomeCategory, false);
      expect(metadata.isExpenseCategory, true);
    });

    test('isExpenseCategory should be opposite of isIncomeCategory', () {
      const incomeMetadata = CategoryMetadata(
        category: TransactionCategory.salary,
        displayName: 'Salary',
        icon: Icons.account_balance_wallet,
        color: Color(0xFF06FFA5),
        isIncomeCategory: true,
      );

      const expenseMetadata = CategoryMetadata(
        category: TransactionCategory.food,
        displayName: 'Food',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B6B),
        isIncomeCategory: false,
      );

      expect(incomeMetadata.isExpenseCategory, false);
      expect(expenseMetadata.isExpenseCategory, true);
    });

    test('toString should return formatted string', () {
      const metadata = CategoryMetadata(
        category: TransactionCategory.food,
        displayName: 'Food',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B6B),
        isIncomeCategory: false,
      );

      expect(
        metadata.toString(),
        'CategoryMetadata(category: TransactionCategory.food, displayName: Food, isIncomeCategory: false)',
      );
    });

    test('equality should work correctly', () {
      const metadata1 = CategoryMetadata(
        category: TransactionCategory.food,
        displayName: 'Food',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B6B),
        isIncomeCategory: false,
      );

      const metadata2 = CategoryMetadata(
        category: TransactionCategory.food,
        displayName: 'Food',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B6B),
        isIncomeCategory: false,
      );

      const metadata3 = CategoryMetadata(
        category: TransactionCategory.transport,
        displayName: 'Transport',
        icon: Icons.directions_car,
        color: Color(0xFF4ECDC4),
        isIncomeCategory: false,
      );

      expect(metadata1, metadata2);
      expect(metadata1, isNot(metadata3));
    });

    test('hashCode should be consistent', () {
      const metadata1 = CategoryMetadata(
        category: TransactionCategory.food,
        displayName: 'Food',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B6B),
        isIncomeCategory: false,
      );

      const metadata2 = CategoryMetadata(
        category: TransactionCategory.food,
        displayName: 'Food',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B6B),
        isIncomeCategory: false,
      );

      expect(metadata1.hashCode, metadata2.hashCode);
    });
  });
}
