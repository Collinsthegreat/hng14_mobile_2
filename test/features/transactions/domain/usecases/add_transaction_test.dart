import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/add_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:expense_tracker/core/constants/app_categories.dart';

class MockTransactionsRepository extends Mock implements TransactionsRepository {}

void main() {
  late AddTransaction useCase;
  late MockTransactionsRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionsRepository();
    useCase = AddTransaction(mockRepository);
    registerFallbackValue(TransactionEntity(
      id: '1',
      title: 'Test',
      amount: 100,
      type: TransactionType.expense,
      category: TransactionCategory.food,
      date: DateTime.now(),
      createdAt: DateTime.now(),
    ));
  });

  final tTransaction = TransactionEntity(
    id: '1',
    title: 'Test Transaction',
    amount: 10.0,
    type: TransactionType.expense,
    category: TransactionCategory.food,
    date: DateTime.now(),
    createdAt: DateTime.now(),
  );

  test('should add transaction to the repository', () async {
    // Arrange
    when(() => mockRepository.addTransaction(any()))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await useCase(tTransaction);

    // Assert
    expect(result, const Right(unit));
    verify(() => mockRepository.addTransaction(tTransaction)).called(1);
  });
}
