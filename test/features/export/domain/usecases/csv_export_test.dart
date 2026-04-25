import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/export/domain/usecases/export_to_csv.dart';
import 'package:expense_tracker/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsRepository extends Mock implements TransactionsRepository {}

void main() {
  late ExportToCsv useCase;
  late MockTransactionsRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionsRepository();
    useCase = ExportToCsv(mockRepository);
  });

  final tStart = DateTime(2024, 1, 1);
  final tEnd = DateTime(2024, 1, 31);

  test('should return file path when export is successful', () async {
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
