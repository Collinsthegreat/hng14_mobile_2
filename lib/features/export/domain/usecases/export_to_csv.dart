import 'dart:io';
import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/errors/failures.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';

@lazySingleton
class ExportToCsv {
  final TransactionsRepository repository;

  ExportToCsv(this.repository);

  Future<Either<Failure, String>> call({
    required DateTime start,
    required DateTime end,
  }) async {
    final result = await repository.getTransactionsByDateRange(start, end);

    return result.fold((failure) => Left(failure), (transactions) async {
      try {
        final List<List<dynamic>> rows = [];

        // Header
        rows.add(['Date', 'Title', 'Amount', 'Type', 'Category', 'Note']);

        for (final transaction in transactions) {
          rows.add([
            transaction.date.toString(),
            transaction.title,
            transaction.amount,
            transaction.type.name,
            transaction.category.name,
            transaction.note ?? '',
          ]);
        }

        String csvData = const ListToCsvConverter().convert(rows);

        final path =
            '\${(await getTemporaryDirectory()).path}/transactions_export_\${DateTime.now().millisecondsSinceEpoch}.csv';
        final file = File(path);
        await file.writeAsString(csvData);

        return Right(path);
      } catch (e) {
        return Left(StorageFailure('Failed to generate CSV: \${e.toString()}'));
      }
    });
  }
}
