import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_tracker/core/constants/app_strings.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';
import '../widgets/category_chip.dart';

class TransactionFormPage extends StatefulWidget {
  final TransactionEntity? transaction;

  const TransactionFormPage({super.key, this.transaction});

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TransactionType _type;
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  TransactionCategory? _selectedCategory;
  late DateTime _selectedDate;

  bool _isRecurring = false;
  RecurringInterval? _recurringInterval;
  DateTime? _recurringEndDate;

  bool get _isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    final t = widget.transaction;
    _type = t?.type ?? TransactionType.expense;
    _titleController = TextEditingController(text: t?.title);
    _amountController = TextEditingController(
      text: t?.amount.toStringAsFixed(2) ?? '',
    );
    _noteController = TextEditingController(text: t?.note);
    _selectedCategory = t?.category;
    _selectedDate = t?.date ?? DateTime.now();
    _isRecurring = t?.isRecurring ?? false;
    _recurringInterval = t?.recurringInterval;
    _recurringEndDate = t?.recurringEndDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.categoryRequired)),
        );
        return;
      }

      if (_isRecurring && _recurringInterval == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.periodRequired)),
        );
        return;
      }

      final amount = double.tryParse(_amountController.text) ?? 0.0;

      final transaction = TransactionEntity(
        id: _isEditing ? widget.transaction!.id : const Uuid().v4(),
        title: _titleController.text.trim(),
        amount: amount,
        type: _type,
        category: _selectedCategory!,
        date: _selectedDate,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        isRecurring: _isRecurring,
        recurringInterval: _isRecurring ? _recurringInterval : null,
        recurringEndDate: _isRecurring ? _recurringEndDate : null,
        createdAt: _isEditing ? widget.transaction!.createdAt : DateTime.now(),
      );

      if (_isEditing) {
        context.read<TransactionsBloc>().add(
          UpdateTransactionEvent(transaction),
        );
      } else {
        context.read<TransactionsBloc>().add(AddTransactionEvent(transaction));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine which categories to show based on selected type
    final availableCategories = _type == TransactionType.income
        ? CategoryHelper.incomeCategories
        : CategoryHelper.expenseCategories;

    // Reset selected category if it does not belong to the selected type
    if (_selectedCategory != null &&
        !availableCategories.contains(_selectedCategory)) {
      _selectedCategory =
          null; // Will trigger a rebuild since it's used directly
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? AppStrings.editTransaction : AppStrings.addTransaction),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<TransactionType>(
                  segments: const [
                    ButtonSegment(
                      value: TransactionType.income,
                      label: Text(AppStrings.income),
                    ),
                    ButtonSegment(
                      value: TransactionType.expense,
                      label: Text(AppStrings.expense),
                    ),
                  ],
                  selected: {_type},
                  onSelectionChanged: (Set<TransactionType> selection) {
                    setState(() {
                      _type = selection.first;
                    });
                  },
                ),
                Gap(24.h),

                CustomTextField(
                  controller: _amountController,
                  label: AppStrings.amount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixIcon: Icons.attach_money,
                  validator: (val) {
                    if (val == null || val.isEmpty) return AppStrings.amountRequired;
                    final parsed = double.tryParse(val);
                    if (parsed == null || parsed <= 0)
                      return AppStrings.amountMustBePositive;
                    return null;
                  },
                ),
                Gap(16.h),

                CustomTextField(
                  controller: _titleController,
                  label: AppStrings.title,
                  prefixIcon: Icons.title,
                  maxLength: 100,
                  validator: (val) =>
                      val == null || val.isEmpty ? AppStrings.titleRequired : null,
                ),
                Gap(16.h),

                Text(
                  AppStrings.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Gap(8.h),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: availableCategories.map((cat) {
                    return CategoryChip(
                      category: cat,
                      isSelected: _selectedCategory == cat,
                      onTap: () {
                        setState(() {
                          _selectedCategory = cat;
                        });
                      },
                    );
                  }).toList(),
                ),
                Gap(24.h),

                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: AppStrings.date,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('MMMM dd, yyyy').format(_selectedDate)),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                Gap(16.h),

                CustomTextField(
                  controller: _noteController,
                  label: '\${AppStrings.note} (\${AppStrings.optional})',
                  maxLines: 3,
                  prefixIcon: Icons.notes,
                ),
                Gap(24.h),

                SwitchListTile(
                  title: const Text(AppStrings.recurring),
                  value: _isRecurring,
                  onChanged: (val) {
                    setState(() {
                      _isRecurring = val;
                      if (!val) {
                        _recurringInterval = null;
                        _recurringEndDate = null;
                      }
                    });
                  },
                ),
                if (_isRecurring) ...[
                  Gap(8.h),
                  DropdownButtonFormField<RecurringInterval>(
                    value: _recurringInterval,
                    decoration: InputDecoration(
                      labelText: AppStrings.recurringInterval,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    items: RecurringInterval.values.map((i) {
                      return DropdownMenuItem(
                        value: i,
                        child: Text(
                          i.name[0].toUpperCase() + i.name.substring(1),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _recurringInterval = val),
                  ),
                  Gap(16.h),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate.add(
                          const Duration(days: 30),
                        ),
                        firstDate: _selectedDate,
                        lastDate: DateTime(2100),
                      );
                      setState(() {
                        _recurringEndDate = picked;
                      });
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: '\${AppStrings.recurringEndDate} (\${AppStrings.optional})',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _recurringEndDate != null
                                ? DateFormat(
                                    'MMMM dd, yyyy',
                                  ).format(_recurringEndDate!)
                                : 'No end date',
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ],
                Gap(32.h),

                CustomButton(
                  text: AppStrings.saveTransaction,
                  onPressed: _saveTransaction,
                ),
                Gap(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
