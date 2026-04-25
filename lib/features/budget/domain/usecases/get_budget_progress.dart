import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/budget_entity.dart';
import 'package:expense_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/get_transactions_by_category.dart';

@lazySingleton
class GetBudgetProgress {
  final GetTransactionsByCategory getTransactionsByCategory;

  GetBudgetProgress(this.getTransactionsByCategory);

  Future<Either<Failure, BudgetEntity>> call(BudgetEntity budget) async {
    final result = await getTransactionsByCategory(budget.category);

    return result.fold((failure) => Left(failure), (transactions) {
      // Calculate period start and end relative to current date (not just budget.startDate)
      // Usually, a monthly budget limits expenses for the CURRENT month.
      // Based on the prompt: 1. Get budget period. 2. Calculate period start and end dates.
      final now = DateTime.now();
      DateTime periodStart;
      DateTime periodEnd;

      switch (budget.period) {
        case BudgetPeriod.weekly:
          // Calculate start of current week (assuming Monday)
          int daysSinceMonday = now.weekday - DateTime.monday;
          periodStart = DateTime(
            now.year,
            now.month,
            now.day - daysSinceMonday,
          );
          periodEnd = periodStart
              .add(const Duration(days: 7))
              .subtract(const Duration(seconds: 1));
          break;
        case BudgetPeriod.monthly:
          periodStart = DateTime(now.year, now.month, 1);
          int nextMonth = now.month == 12 ? 1 : now.month + 1;
          int nextYear = now.month == 12 ? now.year + 1 : now.year;
          periodEnd = DateTime(
            nextYear,
            nextMonth,
            1,
          ).subtract(const Duration(seconds: 1));
          break;
        case BudgetPeriod.yearly:
          periodStart = DateTime(now.year, 1, 1);
          periodEnd = DateTime(
            now.year + 1,
            1,
            1,
          ).subtract(const Duration(seconds: 1));
          break;
      }

      // Keep transactions only inside period and type = expense
      final validTransactions = transactions.where((t) {
        return t.type == TransactionType.expense &&
            t.date.isAfter(periodStart.subtract(const Duration(seconds: 1))) &&
            t.date.isBefore(periodEnd.add(const Duration(seconds: 1)));
      });

      double spentAmount = validTransactions.fold(
        0.0,
        (sum, t) => sum + t.amount,
      );

      return Right(budget.copyWith(spentAmount: spentAmount));
    });
  }
}
