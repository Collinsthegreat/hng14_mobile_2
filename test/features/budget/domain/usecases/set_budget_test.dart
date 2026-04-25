import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/budget/domain/entities/budget_entity.dart';
import 'package:expense_tracker/features/budget/domain/repositories/budget_repository.dart';
import 'package:expense_tracker/features/budget/domain/usecases/set_budget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:expense_tracker/core/constants/app_categories.dart';

class MockBudgetRepository extends Mock implements BudgetRepository {}

void main() {
  late SetBudget useCase;
  late MockBudgetRepository mockRepository;

  setUp(() {
    mockRepository = MockBudgetRepository();
    useCase = SetBudget(mockRepository);
    registerFallbackValue(BudgetEntity(
      id: '1',
      category: TransactionCategory.food,
      limitAmount: 100,
      period: BudgetPeriod.monthly,
      startDate: DateTime.now(),
      createdAt: DateTime.now(),
    ));
  });

  final tBudget = BudgetEntity(
    id: '1',
    category: TransactionCategory.food,
    limitAmount: 100,
    period: BudgetPeriod.monthly,
    startDate: DateTime.now(),
    createdAt: DateTime.now(),
  );

  test('should set budget in the repository', () async {
    // Arrange
    when(() => mockRepository.addBudget(any()))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(tBudget);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.addBudget(tBudget)).called(1);
  });
}
