import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_spending_by_category.dart';
import '../../domain/usecases/get_monthly_trend.dart';
import '../../domain/usecases/get_income_vs_expense.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

@injectable
class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetSpendingByCategory getSpendingByCategory;
  final GetMonthlyTrend getMonthlyTrend;
  final GetIncomeVsExpense getIncomeVsExpense;

  AnalyticsBloc({
    required this.getSpendingByCategory,
    required this.getMonthlyTrend,
    required this.getIncomeVsExpense,
  }) : super(AnalyticsInitial()) {
    on<LoadAnalyticsData>(_onLoadAnalyticsData);
  }

  Future<void> _onLoadAnalyticsData(
    LoadAnalyticsData event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(AnalyticsLoading());

    final now = DateTime.now();
    DateTime start;
    DateTime end = now;

    switch (event.period) {
      case AnalyticsPeriod.thisWeek:
        start = now.subtract(Duration(days: now.weekday - 1));
        start = DateTime(start.year, start.month, start.day);
        break;
      case AnalyticsPeriod.thisMonth:
        start = DateTime(now.year, now.month, 1);
        break;
      case AnalyticsPeriod.thisYear:
        start = DateTime(now.year, 1, 1);
        break;
      case AnalyticsPeriod.custom:
        start = event.start ?? now.subtract(const Duration(days: 30));
        end = event.end ?? now;
        break;
    }

    final categoryResult = await getSpendingByCategory(start: start, end: end);
    final trendResult = await getMonthlyTrend(start: start, end: end);
    final comparisonResult = await getIncomeVsExpense(start: start, end: end);

    categoryResult.fold((failure) => emit(AnalyticsError(failure.message)), (
      spendingByCategory,
    ) {
      trendResult.fold((failure) => emit(AnalyticsError(failure.message)), (
        monthlyTrend,
      ) {
        comparisonResult.fold(
          (failure) => emit(AnalyticsError(failure.message)),
          (incomeVsExpense) {
            emit(
              AnalyticsLoaded(
                spendingByCategory: spendingByCategory,
                monthlyTrend: monthlyTrend,
                incomeVsExpense: incomeVsExpense,
                start: start,
                end: end,
              ),
            );
          },
        );
      });
    });
  }
}
