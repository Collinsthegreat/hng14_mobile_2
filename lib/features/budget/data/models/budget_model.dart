import 'package:hive/hive.dart';
import '../../../../core/constants/app_categories.dart';
import '../../domain/entities/budget_entity.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 1)
class BudgetModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final TransactionCategory category;

  @HiveField(2)
  final double limitAmount;

  @HiveField(3)
  final BudgetPeriod period;

  @HiveField(4)
  final DateTime startDate;

  @HiveField(5)
  final DateTime createdAt;

  const BudgetModel({
    required this.id,
    required this.category,
    required this.limitAmount,
    required this.period,
    required this.startDate,
    required this.createdAt,
  });

  factory BudgetModel.fromEntity(BudgetEntity entity) {
    return BudgetModel(
      id: entity.id,
      category: entity.category,
      limitAmount: entity.limitAmount,
      period: entity.period,
      startDate: entity.startDate,
      createdAt: entity.createdAt,
    );
  }

  BudgetEntity toEntity() {
    return BudgetEntity(
      id: id,
      category: category,
      limitAmount: limitAmount,
      period: period,
      startDate: startDate,
      createdAt: createdAt,
    );
  }
}
