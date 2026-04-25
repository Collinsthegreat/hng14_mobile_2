import 'package:hive/hive.dart';
import '../../../../core/constants/app_categories.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final TransactionType type;

  @HiveField(4)
  final TransactionCategory category;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final String? note;

  @HiveField(7)
  final bool isRecurring;

  @HiveField(8)
  final RecurringInterval? recurringInterval;

  @HiveField(9)
  final DateTime? recurringEndDate;

  @HiveField(10)
  final DateTime createdAt;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note,
    required this.isRecurring,
    this.recurringInterval,
    this.recurringEndDate,
    required this.createdAt,
  });

  /// Creates a model from a domain entity.
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      type: entity.type,
      category: entity.category,
      date: entity.date,
      note: entity.note,
      isRecurring: entity.isRecurring,
      recurringInterval: entity.recurringInterval,
      recurringEndDate: entity.recurringEndDate,
      createdAt: entity.createdAt,
    );
  }

  /// Converts the model to a domain entity.
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      title: title,
      amount: amount,
      type: type,
      category: category,
      date: date,
      note: note,
      isRecurring: isRecurring,
      recurringInterval: recurringInterval,
      recurringEndDate: recurringEndDate,
      createdAt: createdAt,
    );
  }
}
