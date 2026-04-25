import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsRepository extends Mock implements TransactionsRepository {}

void main() {
  late DeleteTransaction useCase;
  late MockTransactionsRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionsRepository();
    useCase = DeleteTransaction(mockRepository);
  });

  const tId = '1';

  test('should delete transaction from the repository', () async {
    // Arrange
    when(() => mockRepository.deleteTransaction(any()))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await useCase(tId);

    // Assert
    expect(result, const Right(unit));
    verify(() => mockRepository.deleteTransaction(tId)).called(1);
  });
}
