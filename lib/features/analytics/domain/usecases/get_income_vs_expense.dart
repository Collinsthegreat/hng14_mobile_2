import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../transactions/domain/entities/transaction_entity.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';

@lazySingleton
class GetIncomeVsExpense {
  final TransactionsRepository repository;

  GetIncomeVsExpense(this.repository);

  Future<Either<Failure, IncomeVsExpenseData>> call({
    required DateTime start,
    required DateTime end,
  }) async {
    final result = await repository.getTransactionsByDateRange(start, end);

    return result.fold((failure) => Left(failure), (transactions) {
      double income = 0;
      double expense = 0;

      for (final transaction in transactions) {
        if (transaction.type == TransactionType.income) {
          income += transaction.amount;
        } else {
          expense += transaction.amount;
        }
      }

      return Right(IncomeVsExpenseData(income: income, expense: expense));
    });
  }
}

class IncomeVsExpenseData {
  final double income;
  final double expense;

  IncomeVsExpenseData({required this.income, required this.expense});
}
