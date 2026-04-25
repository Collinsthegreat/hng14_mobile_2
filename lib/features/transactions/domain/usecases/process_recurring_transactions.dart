import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transactions_repository.dart';

/// Use case to process and auto-generate recurring transactions.
@lazySingleton
class ProcessRecurringTransactions {
  final TransactionsRepository repository;

  ProcessRecurringTransactions(this.repository);

  /// Executes the use case.
  Future<Either<Failure, Unit>> call() async {
    final result = await repository.getAllTransactions();

    return result.fold((failure) => Left(failure), (transactions) async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Find recurring transactions (templates)
      final recurringTemplates = transactions
          .where((t) => t.isRecurring)
          .toList();

      for (final template in recurringTemplates) {
        // If the template has an end date, and it has already passed, skip
        if (template.recurringEndDate != null &&
            template.recurringEndDate!.isBefore(today)) {
          continue;
        }

        // Calculate the next due date based on the original date and interval
        // For a robust implementation, we check the latest generated transaction
        // that matches this template's properties, or simply iterate from the
        // creation/start date until we pass 'today'.

        // simplified approach: just generate the next ones if needed
        DateTime nextDate = _calculateNextDate(
          template.date,
          template.recurringInterval!,
        );

        while (!nextDate.isAfter(today) &&
            (template.recurringEndDate == null ||
                !nextDate.isAfter(template.recurringEndDate!))) {
          // Check if we already have a generated transaction for this specific date
          // to avoid duplicates (same title, amount, category, date, but not marked as recurring template)
          final alreadyGenerated = transactions.any(
            (t) =>
                !t.isRecurring &&
                t.title == template.title &&
                t.category == template.category &&
                t.amount == template.amount &&
                _isSameDay(t.date, nextDate),
          );

          if (!alreadyGenerated) {
            // Generate the new transaction
            final newTransaction = TransactionEntity(
              id: const Uuid().v4(),
              title: template.title,
              amount: template.amount,
              type: template.type,
              category: template.category,
              date: nextDate,
              note: template.note,
              isRecurring:
                  false, // The generated one is just a log, not a template itself
              createdAt: DateTime.now(),
            );

            final addResult = await repository.addTransaction(newTransaction);
            if (addResult.isLeft()) {
              // If it fails, we might just log and continue, or return the failure
              return addResult;
            }
          }

          // Move to next interval
          nextDate = _calculateNextDate(nextDate, template.recurringInterval!);
        }
      }

      return const Right(unit);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime _calculateNextDate(DateTime fromDate, RecurringInterval interval) {
    switch (interval) {
      case RecurringInterval.daily:
        return fromDate.add(const Duration(days: 1));
      case RecurringInterval.weekly:
        return fromDate.add(const Duration(days: 7));
      case RecurringInterval.monthly:
        // Proper monthly addition handling end-of-month cases
        int nextMonth = fromDate.month + 1;
        int nextYear = fromDate.year;
        if (nextMonth > 12) {
          nextMonth = 1;
          nextYear++;
        }
        // Handle max days in month
        int daysInNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
        int nextDay = fromDate.day > daysInNextMonth
            ? daysInNextMonth
            : fromDate.day;
        return DateTime(
          nextYear,
          nextMonth,
          nextDay,
          fromDate.hour,
          fromDate.minute,
          fromDate.second,
        );
      case RecurringInterval.yearly:
        // Handle leap years
        int nextYear = fromDate.year + 1;
        int daysInMonth = DateTime(nextYear, fromDate.month + 1, 0).day;
        int nextDay = fromDate.day > daysInMonth ? daysInMonth : fromDate.day;
        return DateTime(
          nextYear,
          fromDate.month,
          nextDay,
          fromDate.hour,
          fromDate.minute,
          fromDate.second,
        );
    }
  }
}
