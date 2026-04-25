import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/theme/app_colors.dart';

class CategoryPieChart extends StatelessWidget {
  final Map<TransactionCategory, double> data;

  const CategoryPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          'No data for this period',
          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40.r,
          sections: _showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    final total = data.values.fold(0.0, (sum, item) => sum + item);

    return data.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      final isLarge = percentage > 5;

      return PieChartSectionData(
        color: entry.key.color,
        value: entry.value,
        title: isLarge ? '\${percentage.toStringAsFixed(0)}%' : '',
        radius: 50.r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
