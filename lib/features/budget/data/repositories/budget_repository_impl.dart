import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/budget_entity.dart';
import '../../domain/repositories/budget_repository.dart';
import '../datasources/budget_local_datasource.dart';
import '../models/budget_model.dart';

@LazySingleton(as: BudgetRepository)
class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource dataSource;

  BudgetRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<BudgetEntity>>> getAllBudgets() async {
    try {
      final models = await dataSource.getAllBudgets();
      return Right(models.map((model) => model.toEntity()).toList());
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> setBudget(BudgetEntity budget) async {
    try {
      await dataSource.setBudget(BudgetModel.fromEntity(budget));
      return const Right(unit);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBudget(BudgetEntity budget) async {
    try {
      await dataSource.updateBudget(BudgetModel.fromEntity(budget));
      return const Right(unit);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBudget(String id) async {
    try {
      await dataSource.deleteBudget(id);
      return const Right(unit);
    } on HiveError catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure('Unexpected error occurred'));
    }
  }
}
