import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'transaction_form_page.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/core/constants/app_strings.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';
import '../bloc/transactions_state.dart';
import '../widgets/transaction_card.dart';
import '../widgets/transaction_filter_bar.dart';

class TransactionsListPage extends StatefulWidget {
  const TransactionsListPage({super.key});

  @override
  State<TransactionsListPage> createState() => _TransactionsListPageState();
}

class _TransactionsListPageState extends State<TransactionsListPage> {
  TransactionType? _selectedType;
  TransactionCategory? _selectedCategory;
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TransactionsBloc>().add(LoadTransactions());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onFilterChanged() {
    context.read<TransactionsBloc>().add(
      FilterTransactionsEvent(
        type: _selectedType,
        category: _selectedCategory,
        startDate: _startDate,
        endDate: _endDate,
      ),
    );
  }

  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _onFilterChanged();
    }
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return AppStrings.today;
    } else if (dateToCheck == yesterday) {
      return AppStrings.yesterday;
    } else {
      return DateFormat('EEEE, MMM d, yyyy').format(dateToCheck);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.transactions),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppStrings.searchTransactions,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<TransactionsBloc>().add(LoadTransactions());
                  },
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<TransactionsBloc>().add(
                    SearchTransactionsEvent(value),
                  );
                } else {
                  _onFilterChanged();
                }
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: TransactionFilterBar(
              selectedType: _selectedType,
              selectedCategory: _selectedCategory,
              onTypeChanged: (type) {
                setState(() => _selectedType = type);
                _onFilterChanged();
              },
              onCategoryChanged: (cat) {
                setState(() => _selectedCategory = cat);
                _onFilterChanged();
              },
              onDateRangeTap: _showDateRangePicker,
            ),
          ),
          if (_startDate != null && _endDate != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    '${DateFormat('MMM d').format(_startDate!)} - ${DateFormat('MMM d').format(_endDate!)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _startDate = null;
                        _endDate = null;
                      });
                      _onFilterChanged();
                    },
                    child: const Text(AppStrings.clearFilters),
                  ),
                ],
              ),
            ),
          Expanded(
            child: BlocConsumer<TransactionsBloc, TransactionsState>(
              listener: (context, state) {
                if (state is TransactionDeleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(AppStrings.transactionDeleted),
                      action: SnackBarAction(
                        label: AppStrings.undo,
                        onPressed: () {
                          context.read<TransactionsBloc>().add(
                            UndoDeleteTransactionEvent(state.transaction),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is TransactionsLoading) {
                  return const LoadingWidget();
                } else if (state is TransactionsError) {
                  return CustomErrorWidget(
                    message: state.message,
                    onRetry: () => context.read<TransactionsBloc>().add(
                      LoadTransactions(),
                    ),
                  );
                } else if (state is TransactionsLoaded) {
                  if (state.transactions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 100.sp,
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            state.isFiltered
                                ? 'No matching transactions'
                                : 'No transactions yet',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Group transactions by date
                  final Map<String, List<TransactionEntity>> grouped = {};
                  for (var t in state.transactions) {
                    final dateKey =
                        '${t.date.year}-${t.date.month}-${t.date.day}';
                    grouped.putIfAbsent(dateKey, () => []).add(t);
                  }

                  // Ensure sorted dates
                  final sortedKeys = grouped.keys.toList()
                    ..sort((a, b) {
                      final dateA = grouped[a]!.first.date;
                      final dateB = grouped[b]!.first.date;
                      return dateB.compareTo(dateA);
                    });

                  return ListView.builder(
                    itemCount: sortedKeys.length,
                    itemBuilder: (context, index) {
                      final dateKey = sortedKeys[index];
                      final transactionsForDate = grouped[dateKey]!;
                      final headerDate = transactionsForDate.first.date;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDateHeader(headerDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                // Text(
                                //   CurrencyFormatter.formatWithSign(runningBalanceForDate, Currency.ngn),
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //     color: runningBalanceForDate >= 0 ? AppColors.income : AppColors.expense,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          ...transactionsForDate.map(
                            (t) => Dismissible(
                              key: Key(t.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.w),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) {
                                context.read<TransactionsBloc>().add(
                                  DeleteTransactionEvent(t),
                                );
                              },
                              child: TransactionCard(
                                transaction: t,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionFormPage(transaction: t),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TransactionFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
