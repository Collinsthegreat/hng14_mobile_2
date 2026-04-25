import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_categories.dart';
import '../../domain/entities/budget_entity.dart';
import 'budget_progress_bar.dart';

class BudgetCard extends StatelessWidget {
  final BudgetEntity budget;
  final VoidCallback? onTap;

  const BudgetCard({super.key, required this.budget, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Calculate progress and determine status
    final progress = budget.limitAmount > 0
        ? (budget.spentAmount / budget.limitAmount)
        : 0.0;

    String statusText;
    Color statusColor;
    if (progress < 0.7) {
      statusText = 'On Track';
      statusColor = Colors.green;
    } else if (progress < 0.9) {
      statusText = 'Warning';
      statusColor = Colors.orange;
    } else {
      statusText = 'Exceeded';
      statusColor = Colors.red;
    }

    // Calculate remaining days
    final now = DateTime.now();
    switch (budget.period) {
      case BudgetPeriod.weekly:
        break;
      case BudgetPeriod.monthly:
        final nextMonth = now.month == 12 ? 1 : now.month + 1;
        final nextYear = now.month == 12 ? now.year + 1 : now.year;
        break;
      case BudgetPeriod.yearly:
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: budget.category.color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    budget.category.icon,
                    color: budget.category.color,
                    size: 20.sp,
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.category.displayName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '\${budget.period.name[0].toUpperCase()}\${budget.period.name.substring(1)} Budget',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            Gap(16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spent: \${CurrencyFormatter.format(budget.spentAmount, Currency.ngn)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Limit: \${CurrencyFormatter.format(budget.limitAmount, Currency.ngn)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            Gap(8.h),
            BudgetProgressBar(
              limit: budget.limitAmount,
              spent: budget.spentAmount,
            ),
            Gap(8.h),
            Text(
              '\$remainingDays days left',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
