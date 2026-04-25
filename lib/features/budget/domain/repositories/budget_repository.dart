import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/budget_entity.dart';

abstract class BudgetRepository {
  Future<Either<Failure, List<BudgetEntity>>> getAllBudgets();
  Future<Either<Failure, Unit>> setBudget(BudgetEntity budget);
  Future<Either<Failure, Unit>> updateBudget(BudgetEntity budget);
  Future<Either<Failure, Unit>> deleteBudget(String id);
}
