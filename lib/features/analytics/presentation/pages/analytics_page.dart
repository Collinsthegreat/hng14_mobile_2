import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/constants/app_categories.dart';
import '../bloc/analytics_bloc.dart';
import '../bloc/analytics_event.dart';
import '../bloc/analytics_state.dart';
import '../widgets/pie_chart_widget.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/line_chart_widget.dart';
import '../widgets/chart_legend.dart';
import '../../../../core/utils/currency_formatter.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  AnalyticsPeriod _selectedPeriod = AnalyticsPeriod.thisMonth;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<AnalyticsBloc>().add(
      LoadAnalyticsData(period: _selectedPeriod),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Column(
        children: [
          _buildPeriodSelector(),
          Expanded(
            child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
              builder: (context, state) {
                if (state is AnalyticsLoading) {
                  return const LoadingWidget();
                } else if (state is AnalyticsError) {
                  return CustomErrorWidget(
                    message: state.message,
                    onRetry: _loadData,
                  );
                } else if (state is AnalyticsLoaded) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Spending by Category'),
                        SizedBox(height: 16.h),
                        CategoryPieChart(data: state.spendingByCategory),
                        SizedBox(height: 16.h),
                        ChartLegend(data: state.spendingByCategory),
                        SizedBox(height: 32.h),
                        _buildSectionTitle('Category Breakdown'),
                        SizedBox(height: 16.h),
                        _buildCategoryBreakdown(state.spendingByCategory),
                        SizedBox(height: 32.h),
                        _buildSectionTitle('Spending Trend'),
                        SizedBox(height: 16.h),
                        SpendingLineChart(data: state.monthlyTrend),
                        SizedBox(height: 32.h),
                        _buildSectionTitle('Income vs Expense'),
                        SizedBox(height: 16.h),
                        IncomeExpenseBarChart(data: state.incomeVsExpense),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: AnalyticsPeriod.values.map((period) {
            final isSelected = _selectedPeriod == period;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ChoiceChip(
                label: Text(_getPeriodName(period)),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    if (period == AnalyticsPeriod.custom) {
                      _showDateRangePicker(context);
                    } else {
                      setState(() {
                        _selectedPeriod = period;
                      });
                      _loadData();
                    }
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getPeriodName(AnalyticsPeriod period) {
    switch (period) {
      case AnalyticsPeriod.thisWeek:
        return 'This Week';
      case AnalyticsPeriod.thisMonth:
        return 'This Month';
      case AnalyticsPeriod.thisYear:
        return 'This Year';
      case AnalyticsPeriod.custom:
        return 'Custom';
    }
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 30)),
        end: DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        _selectedPeriod = AnalyticsPeriod.custom;
      });
      context.read<AnalyticsBloc>().add(
            LoadAnalyticsData(
              period: AnalyticsPeriod.custom,
              start: picked.start,
              end: picked.end,
            ),
          );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCategoryBreakdown(Map<TransactionCategory, double> data) {
    final sortedEntries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedEntries.length,
      separatorBuilder: (context, index) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final entry = sortedEntries[index];
        return Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: entry.key.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(entry.key.icon, color: entry.key.color, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                entry.key.displayName,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              CurrencyFormatter.format(entry.value, Currency.ngn),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
