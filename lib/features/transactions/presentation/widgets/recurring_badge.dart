import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecurringBadge extends StatelessWidget {
  const RecurringBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.blue.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.repeat, size: 10.sp, color: Colors.blue),
          SizedBox(width: 2.w),
          Text(
            'Recurring',
            style: TextStyle(fontSize: 10.sp, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
