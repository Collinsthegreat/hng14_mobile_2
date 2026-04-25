import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/usecases/get_income_vs_expense.dart';
import '../../../../core/theme/app_colors.dart';

class IncomeExpenseBarChart extends StatelessWidget {
  final IncomeVsExpenseData data;

  const IncomeExpenseBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue() * 1.2,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Income', style: TextStyle(fontSize: 12.sp));
                    case 1:
                      return Text('Expense', style: TextStyle(fontSize: 12.sp));
                    default:
                      return const Text('');
                  }
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
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: data.income,
                  color: AppColors.income,
                  width: 30.w,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: data.expense,
                  color: AppColors.expense,
                  width: 30.w,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getMaxValue() {
    return data.income > data.expense ? data.income : data.expense;
  }
}
