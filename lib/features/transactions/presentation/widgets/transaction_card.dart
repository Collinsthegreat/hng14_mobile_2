import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/transaction_entity.dart';
import 'recurring_badge.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;

  const TransactionCard({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine color based on transaction type
    final amountColor = transaction.type == TransactionType.income
        ? AppColors.income
        : AppColors.expense;

    final prefix = transaction.type == TransactionType.income ? '+' : '-';

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
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Category Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: transaction.category.color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                transaction.category.icon,
                color: transaction.category.color,
                size: 24.sp,
              ),
            ),
            Gap(16.w),
            // Title, Note, Badges
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (transaction.note != null &&
                      transaction.note!.isNotEmpty) ...[
                    Gap(4.h),
                    Text(
                      transaction.note!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (transaction.isRecurring) ...[
                    Gap(6.h),
                    const RecurringBadge(),
                  ],
                ],
              ),
            ),
            Gap(16.w),
            // Amount and Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$prefix${CurrencyFormatter.format(transaction.amount, Currency.ngn)}', // using default format here
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: amountColor,
                  ),
                ),
                Gap(4.h),
                Text(
                  DateFormat('MMM dd').format(transaction.date),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
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
