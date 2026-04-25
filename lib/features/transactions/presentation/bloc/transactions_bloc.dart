import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_all_transactions.dart';
import '../../domain/usecases/process_recurring_transactions.dart';
import '../../domain/usecases/update_transaction.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';
import '../../domain/entities/transaction_entity.dart';

@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetAllTransactions getAllTransactions;
  final AddTransaction addTransaction;
  final UpdateTransaction updateTransaction;
  final DeleteTransaction deleteTransaction;
  final ProcessRecurringTransactions processRecurringTransactions;

  // Storing the full list in memory allows fast local filtering
  List<TransactionEntity> _allTransactions = [];

  TransactionsBloc({
    required this.getAllTransactions,
    required this.addTransaction,
    required this.updateTransaction,
    required this.deleteTransaction,
    required this.processRecurringTransactions,
  }) : super(TransactionsInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<UndoDeleteTransactionEvent>(_onUndoDeleteTransaction);
    on<FilterTransactionsEvent>(_onFilterTransactions);
    on<SearchTransactionsEvent>(_onSearchTransactions);
    on<ProcessRecurringEvent>(_onProcessRecurring);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(TransactionsLoading());
    final result = await getAllTransactions();
    result.fold((failure) => emit(TransactionsError(failure.message)), (
      transactions,
    ) {
      _allTransactions = transactions;
      emit(TransactionsLoaded(transactions: transactions));
    });
  }

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    // Keep reference to old state to revert if needed
    final result = await addTransaction(event.transaction);
    result.fold((failure) => emit(TransactionsError(failure.message)), (_) {
      // Successful addition. Reload to ensure order and refresh everything.
      emit(TransactionAdded(event.transaction));
      add(LoadTransactions());
    });
  }

  Future<void> _onUpdateTransaction(
    UpdateTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    final result = await updateTransaction(event.transaction);
    result.fold((failure) => emit(TransactionsError(failure.message)), (_) {
      emit(TransactionUpdated(event.transaction));
      add(LoadTransactions());
    });
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    final result = await deleteTransaction(event.transaction.id);
    result.fold((failure) => emit(TransactionsError(failure.message)), (_) {
      emit(TransactionDeleted(event.transaction));
      add(LoadTransactions());
    });
  }

  Future<void> _onUndoDeleteTransaction(
    UndoDeleteTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    // Restoring a deleted transaction is identically an 'add'
    final result = await addTransaction(event.transaction);
    result.fold(
      (failure) =>
          emit(TransactionsError('Failed to undo: \${failure.message}')),
      (_) {
        emit(TransactionAdded(event.transaction));
        add(LoadTransactions());
      },
    );
  }

  void _onFilterTransactions(
    FilterTransactionsEvent event,
    Emitter<TransactionsState> emit,
  ) {
    List<TransactionEntity> filtered = List.from(_allTransactions);

    if (event.type != null) {
      filtered = filtered.where((t) => t.type == event.type).toList();
    }

    if (event.category != null) {
      filtered = filtered.where((t) => t.category == event.category).toList();
    }

    if (event.startDate != null && event.endDate != null) {
      filtered = filtered.where((t) {
        return t.date.isAfter(
              event.startDate!.subtract(const Duration(seconds: 1)),
            ) &&
            t.date.isBefore(event.endDate!.add(const Duration(seconds: 1)));
      }).toList();
    }

    final isFiltered =
        event.type != null ||
        event.category != null ||
        (event.startDate != null && event.endDate != null);

    emit(TransactionsLoaded(transactions: filtered, isFiltered: isFiltered));
  }

  void _onSearchTransactions(
    SearchTransactionsEvent event,
    Emitter<TransactionsState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(TransactionsLoaded(transactions: _allTransactions));
      return;
    }

    final queryStr = event.query.toLowerCase();
    final filtered = _allTransactions.where((t) {
      final matchesTitle = t.title.toLowerCase().contains(queryStr);
      final matchesNote = t.note?.toLowerCase().contains(queryStr) ?? false;
      return matchesTitle || matchesNote;
    }).toList();

    emit(TransactionsLoaded(transactions: filtered, isFiltered: true));
  }

  Future<void> _onProcessRecurring(
    ProcessRecurringEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    final result = await processRecurringTransactions();
    result.fold((failure) => emit(TransactionsError(failure.message)), (_) {
      add(LoadTransactions()); // Refresh after processing
    });
  }
}
