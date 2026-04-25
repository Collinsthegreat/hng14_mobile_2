import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/budget_model.dart';

abstract class BudgetLocalDataSource {
  Future<List<BudgetModel>> getAllBudgets();
  Future<void> setBudget(BudgetModel budget);
  Future<void> updateBudget(BudgetModel budget);
  Future<void> deleteBudget(String id);
}

@LazySingleton(as: BudgetLocalDataSource)
class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  final Box<BudgetModel> box;

  BudgetLocalDataSourceImpl(@Named('budgets_box') this.box);

  @override
  Future<List<BudgetModel>> getAllBudgets() async {
    return box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> setBudget(BudgetModel budget) async {
    await box.put(budget.id, budget);
  }

  @override
  Future<void> updateBudget(BudgetModel budget) async {
    if (!box.containsKey(budget.id)) {
      throw HiveError('Budget with id \${budget.id} not found.');
    }
    await box.put(budget.id, budget);
  }

  @override
  Future<void> deleteBudget(String id) async {
    await box.delete(id);
  }
}
