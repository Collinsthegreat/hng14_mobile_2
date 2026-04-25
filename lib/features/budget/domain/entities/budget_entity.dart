import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_categories.dart';
import 'package:hive/hive.dart';

part 'budget_entity.g.dart';

@HiveType(typeId: 5)
enum BudgetPeriod {
  @HiveField(0)
  weekly,
  @HiveField(1)
  monthly,
  @HiveField(2)
  yearly,
}

class BudgetEntity extends Equatable {
  final String id;
  final TransactionCategory category;
  final double limitAmount;
  final BudgetPeriod period;
  final DateTime startDate;
  final DateTime createdAt;

  // Computed field (not stored directly in Hive)
  final double spentAmount;

  const BudgetEntity({
    required this.id,
    required this.category,
    required this.limitAmount,
    required this.period,
    required this.startDate,
    required this.createdAt,
    this.spentAmount = 0.0,
  });

  BudgetEntity copyWith({
    String? id,
    TransactionCategory? category,
    double? limitAmount,
    BudgetPeriod? period,
    DateTime? startDate,
    DateTime? createdAt,
    double? spentAmount,
  }) {
    return BudgetEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      limitAmount: limitAmount ?? this.limitAmount,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      createdAt: createdAt ?? this.createdAt,
      spentAmount: spentAmount ?? this.spentAmount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    category,
    limitAmount,
    period,
    startDate,
    createdAt,
    spentAmount,
  ];
}
