import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/add_transaction.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/get_all_transactions.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/process_recurring_transactions.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/update_transaction.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllTransactions extends Mock implements GetAllTransactions {}
class MockAddTransaction extends Mock implements AddTransaction {}
class MockUpdateTransaction extends Mock implements UpdateTransaction {}
class MockDeleteTransaction extends Mock implements DeleteTransaction {}
class MockProcessRecurringTransactions extends Mock implements ProcessRecurringTransactions {}

void main() {
  late TransactionsBloc bloc;
  late MockGetAllTransactions mockGetAll;
  late MockAddTransaction mockAdd;
  late MockUpdateTransaction mockUpdate;
  late MockDeleteTransaction mockDelete;
  late MockProcessRecurringTransactions mockProcessRecurring;

  setUp(() {
    mockGetAll = MockGetAllTransactions();
    mockAdd = MockAddTransaction();
    mockUpdate = MockUpdateTransaction();
    mockDelete = MockDeleteTransaction();
    mockProcessRecurring = MockProcessRecurringTransactions();

    bloc = TransactionsBloc(
      getAllTransactions: mockGetAll,
      addTransaction: mockAdd,
      updateTransaction: mockUpdate,
      deleteTransaction: mockDelete,
      processRecurringTransactions: mockProcessRecurring,
    );
  });

  tearDown(() => bloc.close());

  group('TransactionsBloc', () {
    test('initial state is TransactionsInitial', () {
      expect(bloc.state, const TransactionsInitial());
    });

    blocTest<TransactionsBloc, TransactionsState>(
      'emits [TransactionsLoading, TransactionsLoaded] when LoadTransactions is successful',
      build: () {
        when(() => mockGetAll()).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTransactions()),
      expect: () => [
        const TransactionsLoading(),
        const TransactionsLoaded(transactions: []),
      ],
    );
  });
}
