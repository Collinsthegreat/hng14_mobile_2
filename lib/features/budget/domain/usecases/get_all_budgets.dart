import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/budget_entity.dart';
import '../repositories/budget_repository.dart';

@lazySingleton
class GetAllBudgets {
  final BudgetRepository repository;

  GetAllBudgets(this.repository);

  Future<Either<Failure, List<BudgetEntity>>> call() {
    return repository.getAllBudgets();
  }
}
