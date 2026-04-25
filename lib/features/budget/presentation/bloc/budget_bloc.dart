import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_all_budgets.dart';
import '../../domain/usecases/set_budget.dart';
import '../../domain/usecases/update_budget.dart';
import '../../domain/usecases/delete_budget.dart';
import '../../domain/usecases/get_budget_progress.dart';
import '../../domain/entities/budget_entity.dart';
import 'budget_event.dart';
import 'budget_state.dart';

@injectable
class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetAllBudgets getAllBudgets;
  final SetBudget setBudget;
  final UpdateBudget updateBudget;
  final DeleteBudget deleteBudget;
  final GetBudgetProgress getBudgetProgress;

  BudgetBloc({
    required this.getAllBudgets,
    required this.setBudget,
    required this.updateBudget,
    required this.deleteBudget,
    required this.getBudgetProgress,
  }) : super(BudgetInitial()) {
    on<LoadBudgets>(_onLoadBudgets);
    on<AddBudgetEvent>(_onAddBudget);
    on<UpdateBudgetEvent>(_onUpdateBudget);
    on<DeleteBudgetEvent>(_onDeleteBudget);
  }

  Future<void> _onLoadBudgets(
    LoadBudgets event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading());
    final result = await getAllBudgets();

    await result.fold((failure) async => emit(BudgetError(failure.message)), (
      budgets,
    ) async {
      // Calculate progress for each budget before emitting
      final List<BudgetEntity> budgetsWithProgress = [];
      for (var b in budgets) {
        final progressResult = await getBudgetProgress(b);
        progressResult.fold(
          (l) => budgetsWithProgress.add(b),
          (budgetWithProgress) => budgetsWithProgress.add(budgetWithProgress),
        );
      }

      emit(BudgetLoaded(budgetsWithProgress));
    });
  }

  Future<void> _onAddBudget(
    AddBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    final result = await setBudget(event.budget);
    result.fold((failure) => emit(BudgetError(failure.message)), (_) {
      emit(BudgetAdded());
      add(LoadBudgets());
    });
  }

  Future<void> _onUpdateBudget(
    UpdateBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    final result = await updateBudget(event.budget);
    result.fold((failure) => emit(BudgetError(failure.message)), (_) {
      emit(BudgetUpdated());
      add(LoadBudgets());
    });
  }

  Future<void> _onDeleteBudget(
    DeleteBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    final result = await deleteBudget(event.id);
    result.fold((failure) => emit(BudgetError(failure.message)), (_) {
      emit(BudgetDeleted());
      add(LoadBudgets());
    });
  }
}
