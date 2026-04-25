import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/theme/app_colors.dart';

class IncomeExpenseSummary extends StatelessWidget {
  final double income;
  final double expense;

  const IncomeExpenseSummary({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Income',
            amount: income,
            icon: Icons.arrow_downward,
            color: Colors.green,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _SummaryCard(
            title: 'Expense',
            amount: expense,
            icon: Icons.arrow_upward,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 16.sp),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            CurrencyFormatter.format(amount, Currency.ngn),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
