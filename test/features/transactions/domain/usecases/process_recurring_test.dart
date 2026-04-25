import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/process_recurring_transactions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsRepository extends Mock implements TransactionsRepository {}

void main() {
  late ProcessRecurringTransactions useCase;
  late MockTransactionsRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionsRepository();
    useCase = ProcessRecurringTransactions(mockRepository);
  });

  test('should call getAllTransactions on repository', () async {
    // Arrange
    when(() => mockRepository.getAllTransactions())
        .thenAnswer((_) async => const Right([]));

    // Act
    final result = await useCase();

    // Assert
    expect(result, const Right(unit));
    verify(() => mockRepository.getAllTransactions()).called(1);
  });
}
