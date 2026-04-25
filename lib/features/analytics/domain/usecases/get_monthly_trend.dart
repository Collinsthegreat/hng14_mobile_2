import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../transactions/domain/entities/transaction_entity.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';

@lazySingleton
class GetMonthlyTrend {
  final TransactionsRepository repository;

  GetMonthlyTrend(this.repository);

  Future<Either<Failure, Map<DateTime, double>>> call({
    required DateTime start,
    required DateTime end,
  }) async {
    final result = await repository.getTransactionsByDateRange(start, end);

    return result.fold((failure) => Left(failure), (transactions) {
      final trendMap = <DateTime, double>{};

      for (final transaction in transactions) {
        if (transaction.type == TransactionType.expense) {
          // Group by day for the trend
          final day = DateTime(
            transaction.date.year,
            transaction.date.month,
            transaction.date.day,
          );
          trendMap[day] = (trendMap[day] ?? 0) + transaction.amount;
        }
      }

      return Right(trendMap);
    });
  }
}
