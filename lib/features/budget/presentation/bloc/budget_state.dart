import 'package:equatable/equatable.dart';
import '../../domain/entities/budget_entity.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();
  @override
  List<Object?> get props => [];
}

class BudgetInitial extends BudgetState {
  const BudgetInitial();
}

class BudgetLoading extends BudgetState {
  const BudgetLoading();
}

class BudgetLoaded extends BudgetState {
  final List<BudgetEntity> budgets;
  const BudgetLoaded(this.budgets);
  @override
  List<Object?> get props => [budgets];
}

class BudgetAdded extends BudgetState {
  const BudgetAdded();
}

class BudgetUpdated extends BudgetState {
  const BudgetUpdated();
}

class BudgetDeleted extends BudgetState {
  const BudgetDeleted();
}

class BudgetError extends BudgetState {
  final String message;
  const BudgetError(this.message);
  @override
  List<Object?> get props => [message];
}
