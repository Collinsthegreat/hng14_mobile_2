import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_categories.dart';
import '../../domain/usecases/get_income_vs_expense.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsLoading extends AnalyticsState {
  const AnalyticsLoading();
}

class AnalyticsLoaded extends AnalyticsState {
  final Map<TransactionCategory, double> spendingByCategory;
  final Map<DateTime, double> monthlyTrend;
  final IncomeVsExpenseData incomeVsExpense;
  final DateTime start;
  final DateTime end;

  const AnalyticsLoaded({
    required this.spendingByCategory,
    required this.monthlyTrend,
    required this.incomeVsExpense,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [
    spendingByCategory,
    monthlyTrend,
    incomeVsExpense,
    start,
    end,
  ];
}

class AnalyticsError extends AnalyticsState {
  final String message;

  const AnalyticsError(this.message);

  @override
  List<Object?> get props => [message];
}
