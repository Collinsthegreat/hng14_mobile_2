import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_tracker/core/constants/app_strings.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/budget_entity.dart';
import '../bloc/budget_bloc.dart';
import '../bloc/budget_event.dart';

class BudgetFormPage extends StatefulWidget {
  final BudgetEntity? budget;

  const BudgetFormPage({super.key, this.budget});

  @override
  State<BudgetFormPage> createState() => _BudgetFormPageState();
}

class _BudgetFormPageState extends State<BudgetFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _amountController;
  TransactionCategory? _selectedCategory;
  BudgetPeriod _selectedPeriod = BudgetPeriod.monthly;
  DateTime _startDate = DateTime.now();

  bool get _isEditing => widget.budget != null;

  @override
  void initState() {
    super.initState();
    final b = widget.budget;
    _amountController = TextEditingController(
      text: b?.limitAmount.toStringAsFixed(2) ?? '',
    );
    _selectedCategory = b?.category;
    _selectedPeriod = b?.period ?? BudgetPeriod.monthly;
    _startDate = b?.startDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _saveBudget() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.categoryRequired)),
        );
        return;
      }

      final amount = double.tryParse(_amountController.text) ?? 0.0;

      final budget = BudgetEntity(
        id: _isEditing ? widget.budget!.id : const Uuid().v4(),
        category: _selectedCategory!,
        limitAmount: amount,
        period: _selectedPeriod,
        startDate: _startDate,
        createdAt: _isEditing ? widget.budget!.createdAt : DateTime.now(),
      );

      if (_isEditing) {
        context.read<BudgetBloc>().add(UpdateBudgetEvent(budget));
      } else {
        context.read<BudgetBloc>().add(AddBudgetEvent(budget));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only expense categories can be budgeted
    final availableCategories = CategoryHelper.expenseCategories;

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? AppStrings.editBudget : AppStrings.addBudget)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<TransactionCategory>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: AppStrings.category,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: availableCategories.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Row(
                        children: [
                          Icon(c.icon, color: c.color, size: 20.sp),
                          Gap(8.w),
                          Text(c.displayName),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  validator: (val) =>
                      val == null ? AppStrings.categoryRequired : null,
                ),
                Gap(16.h),

                CustomTextField(
                  controller: _amountController,
                  label: AppStrings.limit,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixIcon: Icons.attach_money,
                  validator: (val) {
                    if (val == null || val.isEmpty) return AppStrings.limitRequired;
                    final parsed = double.tryParse(val);
                    if (parsed == null || parsed <= 0)
                      return AppStrings.limitMustBePositive;
                    return null;
                  },
                ),
                Gap(16.h),

                DropdownButtonFormField<BudgetPeriod>(
                  value: _selectedPeriod,
                  decoration: InputDecoration(
                    labelText: AppStrings.period,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: BudgetPeriod.values.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(
                        p.name[0].toUpperCase() + p.name.substring(1),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedPeriod = val!),
                ),
                Gap(32.h),

                CustomButton(text: AppStrings.saveBudget, onPressed: _saveBudget),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
