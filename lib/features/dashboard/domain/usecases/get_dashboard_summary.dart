import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';
import '../../../transactions/domain/entities/transaction_entity.dart';
import '../../../budget/domain/repositories/budget_repository.dart';
import '../../../budget/domain/usecases/get_budget_progress.dart';
import '../../../budget/domain/entities/budget_entity.dart';
import '../entities/dashboard_summary_entity.dart';

@injectable
class GetDashboardSummary {
  final TransactionsRepository transactionsRepository;
  final BudgetRepository budgetRepository;
  final GetBudgetProgress getBudgetProgress;

  GetDashboardSummary(
    this.transactionsRepository,
    this.budgetRepository,
    this.getBudgetProgress,
  );

  Future<Either<Failure, DashboardSummaryEntity>> call() async {
    final transactionsResult = await transactionsRepository
        .getAllTransactions();
    final budgetsResult = await budgetRepository.getAllBudgets();

    return transactionsResult.fold((failure) => Left(failure), (transactions) {
      return budgetsResult.fold((failure) => Left(failure), (budgets) async {
        final now = DateTime.now();
        double totalBalance = 0;
        double currentMonthIncome = 0;
        double currentMonthExpense = 0;

        for (var t in transactions) {
          if (t.type == TransactionType.income) {
            totalBalance += t.amount;
            if (t.date.year == now.year && t.date.month == now.month) {
              currentMonthIncome += t.amount;
            }
          } else if (t.type == TransactionType.expense) {
            totalBalance -= t.amount;
            if (t.date.year == now.year && t.date.month == now.month) {
              currentMonthExpense += t.amount;
            }
          }
        }

        final sortedTransactions = List<TransactionEntity>.from(transactions)
          ..sort((a, b) => b.date.compareTo(a.date));
        final recentTransactions = sortedTransactions.take(5).toList();

        final activeBudgets = <BudgetEntity>[];
        for (var b in budgets) {
          final progressResult = await getBudgetProgress(b);
          progressResult.fold(
            (l) => activeBudgets.add(b),
            (budgetWithProgress) => activeBudgets.add(budgetWithProgress),
          );
        }

        final Map<TransactionCategory, double> expenseByCategory = {};
        final currentMonthTransactions = transactions
            .where((t) => t.date.year == now.year && t.date.month == now.month)
            .toList();

        for (var t in currentMonthTransactions) {
          if (t.type == TransactionType.expense) {
            expenseByCategory[t.category] =
                (expenseByCategory[t.category] ?? 0) + t.amount;
          }
        }

        final List<MapEntry<DateTime, double>> expenseChartData = [];
        for (int i = 6; i >= 0; i--) {
          final date = now.subtract(Duration(days: i));
          final dayExpenses = currentMonthTransactions
              .where(
                (t) =>
                    t.type == TransactionType.expense &&
                    t.date.day == date.day &&
                    t.date.month == date.month &&
                    t.date.year == date.year,
              )
              .fold(0.0, (sum, t) => sum + t.amount);
          expenseChartData.add(MapEntry(date, dayExpenses));
        }

        return Right(
          DashboardSummaryEntity(
            totalBalance: totalBalance,
            currentMonthIncome: currentMonthIncome,
            currentMonthExpense: currentMonthExpense,
            recentTransactions: recentTransactions,
            activeBudgets: activeBudgets,
            expenseByCategory: expenseByCategory,
            expenseChartData: expenseChartData,
          ),
        );
      });
    });
  }
}
