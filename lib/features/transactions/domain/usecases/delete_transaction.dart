import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/transactions_repository.dart';

/// Use case to delete a transaction.
@lazySingleton
class DeleteTransaction {
  final TransactionsRepository repository;

  DeleteTransaction(this.repository);

  /// Executes the use case.
  Future<Either<Failure, Unit>> call(String id) {
    return repository.deleteTransaction(id);
  }
}
