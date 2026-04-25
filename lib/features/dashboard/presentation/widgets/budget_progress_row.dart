import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expense_tracker/features/budget/presentation/pages/budgets_page.dart';
import 'package:expense_tracker/features/budget/presentation/pages/budget_form_page.dart';
import '../../../budget/domain/entities/budget_entity.dart';
import '../../../budget/presentation/widgets/budget_card.dart';

class BudgetProgressRow extends StatelessWidget {
  final List<BudgetEntity> budgets;

  const BudgetProgressRow({super.key, required this.budgets});

  @override
  Widget build(BuildContext context) {
    if (budgets.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Budgets',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BudgetsPage()),
              ),
              child: const Text('See All'),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: budgets.length,
            itemBuilder: (context, index) {
              final budget = budgets[index];
              return SizedBox(
                width: 280.w,
                child: BudgetCard(
                  budget: budget,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BudgetFormPage(budget: budget),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
