import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/budget/domain/repositories/budget_repository.dart';
import 'package:expense_tracker/features/budget/domain/usecases/get_budget_progress.dart';
import 'package:expense_tracker/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:expense_tracker/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsRepository extends Mock
    implements TransactionsRepository {}

class MockBudgetRepository extends Mock implements BudgetRepository {}

class MockGetBudgetProgress extends Mock implements GetBudgetProgress {}

void main() {
  late GetDashboardSummary useCase;
  late MockTransactionsRepository mockTransactionsRepository;
  late MockBudgetRepository mockBudgetRepository;
  late MockGetBudgetProgress mockGetBudgetProgress;

  setUp(() {
    mockTransactionsRepository = MockTransactionsRepository();
    mockBudgetRepository = MockBudgetRepository();
    mockGetBudgetProgress = MockGetBudgetProgress();
    useCase = GetDashboardSummary(
      mockTransactionsRepository,
      mockBudgetRepository,
      mockGetBudgetProgress,
    );
  });

  test('should get dashboard summary from repositories', () async {
    // Arrange
    when(
      () => mockTransactionsRepository.getAllTransactions(),
    ).thenAnswer((_) async => const Right([]));
    when(
      () => mockBudgetRepository.getAllBudgets(),
    ).thenAnswer((_) async => const Right([]));

    // Act
    final result = await useCase();

    // Assert
    expect(result.isRight(), true);
    verify(() => mockTransactionsRepository.getAllTransactions()).called(1);
    verify(() => mockBudgetRepository.getAllBudgets()).called(1);
  });
}
