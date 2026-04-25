import 'package:equatable/equatable.dart';
import '../../../../features/transactions/domain/entities/transaction_entity.dart';
import '../../../../features/budget/domain/entities/budget_entity.dart';
import '../../../../core/constants/app_categories.dart';

class DashboardSummaryEntity extends Equatable {
  final double totalBalance;
  final double currentMonthIncome;
  final double currentMonthExpense;
  final List<TransactionEntity> recentTransactions;
  final List<BudgetEntity> activeBudgets;
  final Map<TransactionCategory, double> expenseByCategory;
  final List<MapEntry<DateTime, double>> expenseChartData;

  const DashboardSummaryEntity({
    required this.totalBalance,
    required this.currentMonthIncome,
    required this.currentMonthExpense,
    required this.recentTransactions,
    required this.activeBudgets,
    required this.expenseByCategory,
    required this.expenseChartData,
  });

  @override
  List<Object?> get props => [
    totalBalance,
    currentMonthIncome,
    currentMonthExpense,
    recentTransactions,
    activeBudgets,
    expenseByCategory,
    expenseChartData,
  ];
}
