import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/errors/failures.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';

@lazySingleton
class ExportToPdf {
  final TransactionsRepository repository;

  ExportToPdf(this.repository);

  Future<Either<Failure, String>> call({
    required DateTime start,
    required DateTime end,
  }) async {
    final result = await repository.getTransactionsByDateRange(start, end);

    return result.fold((failure) => Left(failure), (transactions) async {
      try {
        final pdf = pw.Document();

        pdf.addPage(
          pw.MultiPage(
            build: (context) => [
              pw.Header(level: 0, child: pw.Text('Transaction Report')),
              pw.Text(
                'Period: \${start.toString().split('
                ')[0]} to \${end.toString().split('
                ')[0]}',
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Title', 'Amount', 'Type', 'Category'],
                data: transactions
                    .map(
                      (t) => [
                        t.date.toString().split(' ')[0],
                        t.title,
                        t.amount.toString(),
                        t.type.name,
                        t.category.name,
                      ],
                    )
                    .toList(),
              ),
            ],
          ),
        );

        final path =
            '\${(await getTemporaryDirectory()).path}/transactions_export_\${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File(path);
        await file.writeAsBytes(await pdf.save());

        return Right(path);
      } catch (e) {
        return Left(StorageFailure('Failed to generate PDF: \${e.toString()}'));
      }
    });
  }
}
