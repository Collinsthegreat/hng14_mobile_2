import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/get_transactions_by_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:expense_tracker/core/constants/app_categories.dart';

class MockTransactionsRepository extends Mock implements TransactionsRepository {}

void main() {
  late GetTransactionsByCategory useCase;
  late MockTransactionsRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionsRepository();
    useCase = GetTransactionsByCategory(mockRepository);
  });

  const tCategory = TransactionCategory.food;
  final tTransactions = [
    TransactionEntity(
      id: '1',
      title: 'Test',
      amount: 100,
      type: TransactionType.expense,
      category: tCategory,
      date: DateTime.now(),
      createdAt: DateTime.now(),
    )
  ];

  test('should get transactions by category from the repository', () async {
    // Arrange
    when(() => mockRepository.getTransactionsByCategory(any()))
        .thenAnswer((_) async => Right(tTransactions));

    // Act
    final result = await useCase(tCategory);

    // Assert
    expect(result, Right(tTransactions));
    verify(() => mockRepository.getTransactionsByCategory(tCategory)).called(1);
  });
}
