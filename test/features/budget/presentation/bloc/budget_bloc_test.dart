import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/budget/domain/usecases/delete_budget.dart';
import 'package:expense_tracker/features/budget/domain/usecases/get_all_budgets.dart';
import 'package:expense_tracker/features/budget/domain/usecases/get_budget_progress.dart';
import 'package:expense_tracker/features/budget/domain/usecases/set_budget.dart';
import 'package:expense_tracker/features/budget/domain/usecases/update_budget.dart';
import 'package:expense_tracker/features/budget/presentation/bloc/budget_bloc.dart';
import 'package:expense_tracker/features/budget/presentation/bloc/budget_event.dart';
import 'package:expense_tracker/features/budget/presentation/bloc/budget_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllBudgets extends Mock implements GetAllBudgets {}
class MockSetBudget extends Mock implements SetBudget {}
class MockUpdateBudget extends Mock implements UpdateBudget {}
class MockDeleteBudget extends Mock implements DeleteBudget {}
class MockGetBudgetProgress extends Mock implements GetBudgetProgress {}

void main() {
  late BudgetBloc bloc;
  late MockGetAllBudgets mockGetAll;
  late MockSetBudget mockSet;
  late MockUpdateBudget mockUpdate;
  late MockDeleteBudget mockDelete;
  late MockGetBudgetProgress mockGetProgress;

  setUp(() {
    mockGetAll = MockGetAllBudgets();
    mockSet = MockSetBudget();
    mockUpdate = MockUpdateBudget();
    mockDelete = MockDeleteBudget();
    mockGetProgress = MockGetBudgetProgress();

    bloc = BudgetBloc(
      getAllBudgets: mockGetAll,
      setBudget: mockSet,
      updateBudget: mockUpdate,
      deleteBudget: mockDelete,
      getBudgetProgress: mockGetProgress,
    );
  });

  tearDown(() => bloc.close());

  group('BudgetBloc', () {
    test('initial state is BudgetInitial', () {
      expect(bloc.state, const BudgetInitial());
    });

    blocTest<BudgetBloc, BudgetState>(
      'emits [BudgetLoading, BudgetLoaded] when LoadBudgets is successful',
      build: () {
        when(() => mockGetAll()).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadBudgets()),
      expect: () => [
        const BudgetLoading(),
        const BudgetLoaded(budgets: []),
      ],
    );
  });
}
