import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction_entity.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

class TransactionsInitial extends TransactionsState {
  const TransactionsInitial();
}

class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

class TransactionsLoaded extends TransactionsState {
  final List<TransactionEntity> transactions;

  // Track active filters so the UI knows what filters are applied
  final bool isFiltered;

  const TransactionsLoaded({
    required this.transactions,
    this.isFiltered = false,
  });

  @override
  List<Object?> get props => [transactions, isFiltered];
}

class TransactionAdded extends TransactionsState {
  final TransactionEntity transaction;

  const TransactionAdded(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionUpdated extends TransactionsState {
  final TransactionEntity transaction;

  const TransactionUpdated(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionDeleted extends TransactionsState {
  final TransactionEntity transaction;

  const TransactionDeleted(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionsError extends TransactionsState {
  final String message;

  const TransactionsError(this.message);

  @override
  List<Object?> get props => [message];
}
