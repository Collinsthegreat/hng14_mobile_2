import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetProgressBar extends StatelessWidget {
  final double spent;
  final double limit;

  const BudgetProgressBar({
    super.key,
    required this.spent,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final progress = limit > 0 ? (spent / limit).clamp(0.0, 1.0) : 0.0;

    Color progressColor;
    if (progress < 0.7) {
      progressColor = Colors.green;
    } else if (progress < 0.9) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.red;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        minHeight: 8.h,
      ),
    );
  }
}
