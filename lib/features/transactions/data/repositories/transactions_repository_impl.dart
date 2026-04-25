import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transactions_repository.dart';
import '../datasources/transactions_local_datasource.dart';
import '../models/transaction_model.dart';

@LazySingleton(as: TransactionsRepository)
class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsLocalDataSource dataSource;

  TransactionsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions() async {
    try {
      final models = await dataSource.getAllTransactions();
      return Right(models.map((model) => model.toEntity()).toList());
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addTransaction(
    TransactionEntity transaction,
  ) async {
    try {
      await dataSource.addTransaction(TransactionModel.fromEntity(transaction));
      return const Right(unit);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTransaction(
    TransactionEntity transaction,
  ) async {
    try {
      await dataSource.updateTransaction(
        TransactionModel.fromEntity(transaction),
      );
      return const Right(unit);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTransaction(String id) async {
    try {
      await dataSource.deleteTransaction(id);
      return const Right(unit);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByCategory(
    TransactionCategory category,
  ) async {
    try {
      final models = await dataSource.getAllTransactions();
      final filtered = models
          .where((model) => model.category == category)
          .map((m) => m.toEntity())
          .toList();
      return Right(filtered);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final models = await dataSource.getAllTransactions();
      final filtered = models
          .where((model) {
            return model.date.isAfter(
                  start.subtract(const Duration(seconds: 1)),
                ) &&
                model.date.isBefore(end.add(const Duration(seconds: 1)));
          })
          .map((m) => m.toEntity())
          .toList();
      return Right(filtered);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }
}
