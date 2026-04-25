import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/errors/failures.dart';
import '../../../transactions/domain/entities/transaction_entity.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';

@lazySingleton
class GetSpendingByCategory {
  final TransactionsRepository repository;

  GetSpendingByCategory(this.repository);

  Future<Either<Failure, Map<TransactionCategory, double>>> call({
    required DateTime start,
    required DateTime end,
  }) async {
    final result = await repository.getTransactionsByDateRange(start, end);

    return result.fold((failure) => Left(failure), (transactions) {
      final spendingMap = <TransactionCategory, double>{};

      for (final transaction in transactions) {
        if (transaction.type == TransactionType.expense) {
          spendingMap[transaction.category] =
              (spendingMap[transaction.category] ?? 0) + transaction.amount;
        }
      }

      return Right(spendingMap);
    });
  }
}
