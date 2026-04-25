import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/budget_entity.dart';
import '../repositories/budget_repository.dart';

@lazySingleton
class SetBudget {
  final BudgetRepository repository;

  SetBudget(this.repository);

  Future<Either<Failure, Unit>> call(BudgetEntity budget) {
    if (budget.limitAmount <= 0) {
      return Future.value(
        const Left(ValidationFailure('Limit must be greater than zero')),
      );
    }
    return repository.setBudget(budget);
  }
}
