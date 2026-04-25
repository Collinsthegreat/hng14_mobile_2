import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/budget/domain/repositories/budget_repository.dart';
import 'package:expense_tracker/features/budget/domain/usecases/get_budget_progress.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:expense_tracker/core/constants/app_categories.dart';

class MockBudgetRepository extends Mock implements BudgetRepository {}

void main() {
  late GetBudgetProgress useCase;
  late MockBudgetRepository mockRepository;

  setUp(() {
    mockRepository = MockBudgetRepository();
    useCase = GetBudgetProgress(mockRepository);
  });

  const tCategory = TransactionCategory.food;

  test('should get budget progress from the repository', () async {
    // Arrange
    when(() => mockRepository.getBudgetProgress(any()))
        .thenAnswer((_) async => const Right(75.0));

    // Act
    final result = await useCase(tCategory);

    // Assert
    expect(result, const Right(75.0));
    verify(() => mockRepository.getBudgetProgress(tCategory)).called(1);
  });
}
