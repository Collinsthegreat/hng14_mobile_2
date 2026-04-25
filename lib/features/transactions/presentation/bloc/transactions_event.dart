import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_categories.dart';
import '../../domain/entities/transaction_entity.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {
  final TransactionEntity transaction;

  const AddTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class UpdateTransactionEvent extends TransactionsEvent {
  final TransactionEntity transaction;

  const UpdateTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionsEvent {
  final TransactionEntity transaction; // Keep the whole entity to allow undo

  const DeleteTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class UndoDeleteTransactionEvent extends TransactionsEvent {
  final TransactionEntity transaction;

  const UndoDeleteTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class FilterTransactionsEvent extends TransactionsEvent {
  final TransactionType? type;
  final TransactionCategory? category;
  final DateTime? startDate;
  final DateTime? endDate;

  const FilterTransactionsEvent({
    this.type,
    this.category,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [type, category, startDate, endDate];
}

class SearchTransactionsEvent extends TransactionsEvent {
  final String query;

  const SearchTransactionsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ProcessRecurringEvent extends TransactionsEvent {}
