import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:expense_tracker/features/budget/data/models/budget_model.dart';
import 'package:expense_tracker/features/transactions/data/models/transaction_model.dart';

@module
abstract class CoreModule {
  @Named('auth_box')
  @lazySingleton
  Box get authBox => Hive.box('auth');

  @Named('budgets_box')
  @lazySingleton
  Box<BudgetModel> get budgetsBox => Hive.box<BudgetModel>('budgets');

  @Named('transactions_box')
  @lazySingleton
  Box<TransactionModel> get transactionsBox =>
      Hive.box<TransactionModel>('transactions');

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
