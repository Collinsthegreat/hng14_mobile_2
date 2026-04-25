import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transactions_repository.dart';

/// Use case to get transactions filtered by category.
@lazySingleton
class GetTransactionsByCategory {
  final TransactionsRepository repository;

  GetTransactionsByCategory(this.repository);

  /// Executes the use case.
  Future<Either<Failure, List<TransactionEntity>>> call(
    TransactionCategory category,
  ) {
    return repository.getTransactionsByCategory(category);
  }
}
