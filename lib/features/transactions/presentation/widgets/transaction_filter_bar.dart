import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_categories.dart';
import '../../domain/entities/transaction_entity.dart';
import 'category_chip.dart';

class TransactionFilterBar extends StatelessWidget {
  final TransactionType? selectedType;
  final TransactionCategory? selectedCategory;
  final Function(TransactionType?) onTypeChanged;
  final Function(TransactionCategory?) onCategoryChanged;
  final VoidCallback onDateRangeTap;

  const TransactionFilterBar({
    super.key,
    required this.selectedType,
    required this.selectedCategory,
    required this.onTypeChanged,
    required this.onCategoryChanged,
    required this.onDateRangeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _buildTypeChip(context, 'All', null),
              Gap(8.w),
              _buildTypeChip(context, 'Income', TransactionType.income),
              Gap(8.w),
              _buildTypeChip(context, 'Expense', TransactionType.expense),
              Gap(8.w),
              Container(
                width: 1,
                height: 24.h,
                color: Colors.grey.withOpacity(0.3),
              ),
              Gap(8.w),
              ActionChip(
                label: const Text('Date Range'),
                avatar: const Icon(Icons.date_range, size: 16),
                onPressed: onDateRangeTap,
              ),
            ],
          ),
        ),
        Gap(12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _buildCategoryChip(
                context,
                null,
                'All Categories',
                Icons.apps,
                Colors.grey,
              ),
              ...TransactionCategory.values.map((cat) {
                return Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: CategoryChip(
                    category: cat,
                    isSelected: selectedCategory == cat,
                    onTap: () => onCategoryChanged(cat),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypeChip(
    BuildContext context,
    String label,
    TransactionType? type,
  ) {
    final isSelected = selectedType == type;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTypeChanged(type),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    TransactionCategory? cat,
    String label,
    IconData icon,
    Color color,
  ) {
    final isSelected = selectedCategory == cat;
    return GestureDetector(
      onTap: () => onCategoryChanged(cat),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.sp, color: color),
            Gap(4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? color : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
