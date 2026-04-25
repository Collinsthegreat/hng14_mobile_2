import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expense_tracker/features/budget/presentation/pages/budget_form_page.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/transaction_form_page.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_state.dart';
import 'package:expense_tracker/features/budget/presentation/bloc/budget_bloc.dart';
import 'package:expense_tracker/features/budget/presentation/bloc/budget_state.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/income_expense_summary.dart';
import '../widgets/recent_transactions_list.dart';
import '../widgets/budget_progress_row.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.dashboardTitle)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TransactionsBloc, TransactionsState>(
            listener: (context, state) {
              if (state is TransactionAdded ||
                  state is TransactionUpdated ||
                  state is TransactionDeleted) {
                context.read<DashboardBloc>().add(LoadDashboardData());
              }
            },
          ),
          BlocListener<BudgetBloc, BudgetState>(
            listener: (context, state) {
              if (state is BudgetAdded ||
                  state is BudgetUpdated ||
                  state is BudgetDeleted) {
                context.read<DashboardBloc>().add(LoadDashboardData());
              }
            },
          ),
        ],
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const LoadingWidget();
            } else if (state is DashboardError) {
              return CustomErrorWidget(
                message: state.message,
                onRetry: () =>
                    context.read<DashboardBloc>().add(LoadDashboardData()),
              );
            } else if (state is DashboardLoaded) {
              final summary = state.summary;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(LoadDashboardData());
              },
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  BalanceCard(balance: summary.totalBalance),
                  SizedBox(height: 16.h),
                  IncomeExpenseSummary(
                    income: summary.currentMonthIncome,
                    expense: summary.currentMonthExpense,
                  ),
                  SizedBox(height: 24.h),
                  BudgetProgressRow(budgets: summary.activeBudgets),
                  SizedBox(height: 24.h),
                  RecentTransactionsList(
                    transactions: summary.recentTransactions,
                  ),
                  SizedBox(height: 80.h), // Space for FAB
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ),
    floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickAddMenu(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showQuickAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.quickAdd,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _QuickAddOption(
                    icon: Icons.receipt_long,
                    label: AppStrings.transactions,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionFormPage(),
                        ),
                      );
                    },
                  ),
                  _QuickAddOption(
                    icon: Icons.pie_chart,
                    label: AppStrings.budget,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BudgetFormPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }
}

class _QuickAddOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAddOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32.sp),
          ),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
