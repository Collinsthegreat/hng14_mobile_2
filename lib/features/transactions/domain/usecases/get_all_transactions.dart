import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transactions_repository.dart';

/// Use case to retrieve all transactions.
@lazySingleton
class GetAllTransactions {
  final TransactionsRepository repository;

  GetAllTransactions(this.repository);

  /// Executes the use case.
  Future<Either<Failure, List<TransactionEntity>>> call() {
    return repository.getAllTransactions();
  }
}
