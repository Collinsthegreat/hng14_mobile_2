import 'package:dartz/dartz.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';

/// Abstract contract for the transactions repository.
abstract class TransactionsRepository {
  /// Retrieves all transactions grouped by date in descending order.
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();

  /// Adds a new transaction to the storage.
  Future<Either<Failure, Unit>> addTransaction(TransactionEntity transaction);

  /// Updates an existing transaction in the storage.
  Future<Either<Failure, Unit>> updateTransaction(
    TransactionEntity transaction,
  );

  /// Deletes a transaction from the storage by its ID.
  Future<Either<Failure, Unit>> deleteTransaction(String id);

  /// Retrieves transactions filtered by a specific category.
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByCategory(
    TransactionCategory category,
  );

  /// Retrieves transactions within a specific date range.
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  );
}
