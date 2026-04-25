import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';

class SpendingLineChart extends StatelessWidget {
  final Map<DateTime, double> data;

  const SpendingLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: const Center(child: Text('No trend data available')),
      );
    }

    final sortedKeys = data.keys.toList()..sort();
    final spots = sortedKeys.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), data[entry.value]!);
    }).toList();

    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedKeys.length) {
                    // Show only first, last and middle date to avoid crowding
                    if (index == 0 ||
                        index == sortedKeys.length - 1 ||
                        index == (sortedKeys.length / 2).floor()) {
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          DateFormat('dd/MM').format(sortedKeys[index]),
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                      );
                    }
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3.w,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
