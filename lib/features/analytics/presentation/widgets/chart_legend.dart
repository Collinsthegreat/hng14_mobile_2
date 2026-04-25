import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_categories.dart';

class ChartLegend extends StatelessWidget {
  final Map<TransactionCategory, double> data;

  const ChartLegend({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 8.h,
      children: data.keys.map((category) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: category.color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
            Text(category.displayName, style: TextStyle(fontSize: 12.sp)),
          ],
        );
      }).toList(),
    );
  }
}
