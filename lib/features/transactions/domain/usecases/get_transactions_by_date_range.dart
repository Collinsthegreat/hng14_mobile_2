import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transactions_repository.dart';

/// Use case to get transactions within a date range.
@lazySingleton
class GetTransactionsByDateRange {
  final TransactionsRepository repository;

  GetTransactionsByDateRange(this.repository);

  /// Executes the use case.
  Future<Either<Failure, List<TransactionEntity>>> call(
    DateTime start,
    DateTime end,
  ) {
    return repository.getTransactionsByDateRange(start, end);
  }
}
