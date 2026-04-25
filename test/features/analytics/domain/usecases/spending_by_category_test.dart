import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/analytics/domain/usecases/get_spending_by_category.dart';
import 'package:expense_tracker/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:expense_tracker/core/constants/app_categories.dart';

class MockTransactionsRepository extends Mock implements TransactionsRepository {}

void main() {
  late GetSpendingByCategory useCase;
  late MockTransactionsRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionsRepository();
    useCase = GetSpendingByCategory(mockRepository);
  });

  final tStart = DateTime(2024, 1, 1);
  final tEnd = DateTime(2024, 1, 31);

  test('should return spending by category map from repository data', () async {
    // Arrange
    when(() => mockRepository.getTransactionsByDateRange(any(), any()))
        .thenAnswer((_) async => const Right([]));

    // Act
    final result = await useCase(tStart, tEnd);

    // Assert
    expect(result.isRight(), true);
    verify(() => mockRepository.getTransactionsByDateRange(tStart, tEnd)).called(1);
  });
}
