import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/transaction_model.dart';

abstract class TransactionsLocalDataSource {
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> addTransaction(TransactionModel transaction);
  Future<void> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String id);
}

@LazySingleton(as: TransactionsLocalDataSource)
class TransactionsLocalDataSourceImpl implements TransactionsLocalDataSource {
  final Box<TransactionModel> box;

  TransactionsLocalDataSourceImpl(@Named('transactions_box') this.box);

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    return box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    await box.put(transaction.id, transaction);
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    if (!box.containsKey(transaction.id)) {
      throw HiveError('Transaction with id ${transaction.id} not found.');
    }
    await box.put(transaction.id, transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await box.delete(id);
  }
}
