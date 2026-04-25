// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i38;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'core/di/core_module.dart' as _i37;
import 'features/analytics/domain/usecases/get_income_vs_expense.dart' as _i23;
import 'features/analytics/domain/usecases/get_monthly_trend.dart' as _i24;
import 'features/analytics/domain/usecases/get_spending_by_category.dart'
    as _i25;
import 'features/analytics/presentation/bloc/analytics_bloc.dart' as _i31;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i18;
import 'features/budget/data/datasources/budget_local_datasource.dart' as _i6;
import 'features/budget/data/models/budget_model.dart' as _i5;
import 'features/budget/data/repositories/budget_repository_impl.dart' as _i8;
import 'features/budget/domain/repositories/budget_repository.dart' as _i7;
import 'features/budget/domain/usecases/delete_budget.dart' as _i9;
import 'features/budget/domain/usecases/get_all_budgets.dart' as _i10;
import 'features/budget/domain/usecases/get_budget_progress.dart' as _i33;
import 'features/budget/domain/usecases/set_budget.dart' as _i11;
import 'features/budget/domain/usecases/update_budget.dart' as _i15;
import 'features/budget/presentation/bloc/budget_bloc.dart' as _i35;
import 'features/dashboard/domain/usecases/get_dashboard_summary.dart' as _i34;
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart' as _i36;
import 'features/export/domain/usecases/export_to_csv.dart' as _i20;
import 'features/export/domain/usecases/export_to_pdf.dart' as _i21;
import 'features/export/presentation/bloc/export_bloc.dart' as _i32;
import 'features/settings/presentation/bloc/settings_bloc.dart' as _i29;
import 'features/transactions/data/datasources/transactions_local_datasource.dart'
    as _i12;
import 'features/transactions/data/models/transaction_model.dart' as _i4;
import 'features/transactions/data/repositories/transactions_repository_impl.dart'
    as _i14;
import 'features/transactions/domain/repositories/transactions_repository.dart'
    as _i13;
import 'features/transactions/domain/usecases/add_transaction.dart' as _i17;
import 'features/transactions/domain/usecases/delete_transaction.dart' as _i19;
import 'features/transactions/domain/usecases/get_all_transactions.dart'
    as _i22;
import 'features/transactions/domain/usecases/get_transactions_by_category.dart'
    as _i26;
import 'features/transactions/domain/usecases/get_transactions_by_date_range.dart'
    as _i27;
import 'features/transactions/domain/usecases/process_recurring_transactions.dart'
    as _i28;
import 'features/transactions/domain/usecases/update_transaction.dart' as _i16;
import 'features/transactions/presentation/bloc/transactions_bloc.dart' as _i30;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i3.Box<_i4.TransactionModel>>(
      () => coreModule.transactionsBox,
      instanceName: 'transactions_box',
    );
    gh.lazySingleton<_i3.Box<_i5.BudgetModel>>(
      () => coreModule.budgetsBox,
      instanceName: 'budgets_box',
    );
    gh.lazySingleton<_i3.Box<dynamic>>(
      () => coreModule.authBox,
      instanceName: 'auth_box',
    );
    gh.lazySingleton<_i38.FlutterSecureStorage>(
      () => coreModule.secureStorage,
    );
    gh.lazySingleton<_i6.BudgetLocalDataSource>(() =>
        _i6.BudgetLocalDataSourceImpl(
            gh<_i3.Box<_i5.BudgetModel>>(instanceName: 'budgets_box')));
    gh.lazySingleton<_i7.BudgetRepository>(
        () => _i8.BudgetRepositoryImpl(gh<_i6.BudgetLocalDataSource>()));
    gh.lazySingleton<_i9.DeleteBudget>(
        () => _i9.DeleteBudget(gh<_i7.BudgetRepository>()));
    gh.lazySingleton<_i10.GetAllBudgets>(
        () => _i10.GetAllBudgets(gh<_i7.BudgetRepository>()));
    gh.lazySingleton<_i11.SetBudget>(
        () => _i11.SetBudget(gh<_i7.BudgetRepository>()));
    gh.lazySingleton<_i12.TransactionsLocalDataSource>(() =>
        _i12.TransactionsLocalDataSourceImpl(gh<_i3.Box<_i4.TransactionModel>>(
            instanceName: 'transactions_box')));
    gh.lazySingleton<_i13.TransactionsRepository>(() =>
        _i14.TransactionsRepositoryImpl(
            gh<_i12.TransactionsLocalDataSource>()));
    gh.lazySingleton<_i15.UpdateBudget>(
        () => _i15.UpdateBudget(gh<_i7.BudgetRepository>()));
    gh.lazySingleton<_i16.UpdateTransaction>(
        () => _i16.UpdateTransaction(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i17.AddTransaction>(
        () => _i17.AddTransaction(gh<_i13.TransactionsRepository>()));
    gh.factory<_i18.AuthBloc>(
        () => _i18.AuthBloc(gh<_i3.Box<dynamic>>(instanceName: 'auth_box')));
    gh.lazySingleton<_i19.DeleteTransaction>(
        () => _i19.DeleteTransaction(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i20.ExportToCsv>(
        () => _i20.ExportToCsv(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i21.ExportToPdf>(
        () => _i21.ExportToPdf(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i22.GetAllTransactions>(
        () => _i22.GetAllTransactions(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i23.GetIncomeVsExpense>(
        () => _i23.GetIncomeVsExpense(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i24.GetMonthlyTrend>(
        () => _i24.GetMonthlyTrend(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i25.GetSpendingByCategory>(
        () => _i25.GetSpendingByCategory(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i26.GetTransactionsByCategory>(() =>
        _i26.GetTransactionsByCategory(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i27.GetTransactionsByDateRange>(() =>
        _i27.GetTransactionsByDateRange(gh<_i13.TransactionsRepository>()));
    gh.lazySingleton<_i28.ProcessRecurringTransactions>(() =>
        _i28.ProcessRecurringTransactions(gh<_i13.TransactionsRepository>()));
    gh.factory<_i29.SettingsBloc>(() => _i29.SettingsBloc(
          secureStorage: gh<_i38.FlutterSecureStorage>(),
          budgetRepository: gh<_i7.BudgetRepository>(),
          transactionsRepository: gh<_i13.TransactionsRepository>(),
        ));
    gh.factory<_i30.TransactionsBloc>(() => _i30.TransactionsBloc(
          getAllTransactions: gh<_i22.GetAllTransactions>(),
          addTransaction: gh<_i17.AddTransaction>(),
          updateTransaction: gh<_i16.UpdateTransaction>(),
          deleteTransaction: gh<_i19.DeleteTransaction>(),
          processRecurringTransactions: gh<_i28.ProcessRecurringTransactions>(),
        ));
    gh.factory<_i31.AnalyticsBloc>(() => _i31.AnalyticsBloc(
          getSpendingByCategory: gh<_i25.GetSpendingByCategory>(),
          getMonthlyTrend: gh<_i24.GetMonthlyTrend>(),
          getIncomeVsExpense: gh<_i23.GetIncomeVsExpense>(),
        ));
    gh.factory<_i32.ExportBloc>(() => _i32.ExportBloc(
          exportToCsv: gh<_i20.ExportToCsv>(),
          exportToPdf: gh<_i21.ExportToPdf>(),
        ));
    gh.lazySingleton<_i33.GetBudgetProgress>(
        () => _i33.GetBudgetProgress(gh<_i26.GetTransactionsByCategory>()));
    gh.factory<_i34.GetDashboardSummary>(() => _i34.GetDashboardSummary(
          gh<_i13.TransactionsRepository>(),
          gh<_i7.BudgetRepository>(),
          gh<_i33.GetBudgetProgress>(),
        ));
    gh.factory<_i35.BudgetBloc>(() => _i35.BudgetBloc(
          getAllBudgets: gh<_i10.GetAllBudgets>(),
          setBudget: gh<_i11.SetBudget>(),
          updateBudget: gh<_i15.UpdateBudget>(),
          deleteBudget: gh<_i9.DeleteBudget>(),
          getBudgetProgress: gh<_i33.GetBudgetProgress>(),
        ));
    gh.factory<_i36.DashboardBloc>(() => _i36.DashboardBloc(
        getDashboardSummary: gh<_i34.GetDashboardSummary>()));
    return this;
  }
}

class _$CoreModule extends _i37.CoreModule {}
