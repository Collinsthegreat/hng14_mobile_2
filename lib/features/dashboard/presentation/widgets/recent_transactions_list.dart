import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/transactions_list_page.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/transaction_form_page.dart';
import '../../../transactions/domain/entities/transaction_entity.dart';
import '../../../transactions/presentation/widgets/transaction_card.dart';

class RecentTransactionsList extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const RecentTransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionsListPage(),
                ),
              ),
              child: const Text('See All'),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return TransactionCard(
              transaction: transaction,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransactionFormPage(transaction: transaction),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
