import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/budget_repository.dart';

@lazySingleton
class DeleteBudget {
  final BudgetRepository repository;

  DeleteBudget(this.repository);

  Future<Either<Failure, Unit>> call(String id) {
    return repository.deleteBudget(id);
  }
}
