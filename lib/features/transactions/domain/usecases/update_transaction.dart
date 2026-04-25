import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transactions_repository.dart';

/// Use case to update an existing transaction.
@lazySingleton
class UpdateTransaction {
  final TransactionsRepository repository;

  UpdateTransaction(this.repository);

  /// Executes the use case.
  Future<Either<Failure, Unit>> call(TransactionEntity transaction) {
    if (transaction.title.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('Title is required')));
    }
    if (transaction.amount <= 0) {
      return Future.value(
        const Left(ValidationFailure('Amount must be greater than zero')),
      );
    }
    return repository.updateTransaction(transaction);
  }
}
