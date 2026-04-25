import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_categories.dart';

import 'package:hive/hive.dart';

part 'transaction_entity.g.dart';

/// Defines the type of a transaction.
@HiveType(typeId: 2)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

/// Defines the frequency of a recurring transaction.
@HiveType(typeId: 4)
enum RecurringInterval {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
  @HiveField(3)
  yearly,
}

/// Represents a financial transaction in the domain layer.
class TransactionEntity extends Equatable {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final TransactionCategory category;
  final DateTime date;
  final String? note;
  final bool isRecurring;
  final RecurringInterval? recurringInterval;
  final DateTime? recurringEndDate;
  final DateTime createdAt;

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note,
    this.isRecurring = false,
    this.recurringInterval,
    this.recurringEndDate,
    required this.createdAt,
  });

  /// Creates a copy of this entity with the given fields replaced with the new values.
  TransactionEntity copyWith({
    String? id,
    String? title,
    double? amount,
    TransactionType? type,
    TransactionCategory? category,
    DateTime? date,
    String? note,
    bool? isRecurring,
    RecurringInterval? recurringInterval,
    DateTime? recurringEndDate,
    DateTime? createdAt,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringInterval: recurringInterval ?? this.recurringInterval,
      recurringEndDate: recurringEndDate ?? this.recurringEndDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    type,
    category,
    date,
    note,
    isRecurring,
    recurringInterval,
    recurringEndDate,
    createdAt,
  ];
}
