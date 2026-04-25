import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'budget_form_page.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/budget_bloc.dart';
import '../bloc/budget_event.dart';
import '../bloc/budget_state.dart';
import '../widgets/budget_card.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  @override
  void initState() {
    super.initState();
    context.read<BudgetBloc>().add(LoadBudgets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: BlocConsumer<BudgetBloc, BudgetState>(
        listener: (context, state) {
          if (state is BudgetDeleted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Budget deleted')));
          }
        },
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const LoadingWidget();
          } else if (state is BudgetError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<BudgetBloc>().add(LoadBudgets()),
            );
          } else if (state is BudgetLoaded) {
            if (state.budgets.isEmpty) {
              return EmptyStateWidget(
                title: 'No active budgets',
                message: 'Start tracking your spending by adding a new budget.',
                actionText: 'Add Budget',
                onActionPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BudgetFormPage(),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: state.budgets.length,
              itemBuilder: (context, index) {
                final budget = state.budgets[index];
                return Dismissible(
                  key: Key(budget.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.w),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text(
                            "Are you sure you wish to delete this budget?",
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("CANCEL"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                "DELETE",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (_) {
                    context.read<BudgetBloc>().add(
                      DeleteBudgetEvent(budget.id),
                    );
                  },
                  child: BudgetCard(
                    budget: budget,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BudgetFormPage(budget: budget),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BudgetFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
