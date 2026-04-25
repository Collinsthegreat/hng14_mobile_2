import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/budget/data/models/budget_model.dart';
import 'features/budget/presentation/bloc/budget_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/transactions/data/models/transaction_model.dart';
import 'features/transactions/presentation/bloc/transactions_bloc.dart';
import 'features/analytics/presentation/bloc/analytics_bloc.dart';
import 'features/export/presentation/bloc/export_bloc.dart';
import 'features/settings/presentation/bloc/settings_state.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'features/auth/presentation/pages/liveness_gate_page.dart';
import 'features/transactions/presentation/bloc/transactions_event.dart';
import 'injection.dart';
import 'core/constants/app_categories.dart';
import 'features/budget/domain/entities/budget_entity.dart';
import 'features/transactions/domain/entities/transaction_entity.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/transactions/presentation/pages/transactions_list_page.dart';
import 'features/budget/presentation/pages/budgets_page.dart';
import 'features/analytics/presentation/pages/analytics_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(BudgetModelAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(BudgetPeriodAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionCategoryAdapter());
  Hive.registerAdapter(RecurringIntervalAdapter());

  // Open Boxes
  await Hive.openBox<BudgetModel>('budgets');
  await Hive.openBox<TransactionModel>('transactions');
  await Hive.openBox('auth');

  // Initialize DI
  configureDependencies();

  // Set BlocObserver
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('onChange: ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError: ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<BudgetBloc>()),
        BlocProvider(create: (_) => getIt<TransactionsBloc>()),
        BlocProvider(create: (_) => getIt<DashboardBloc>()),
        BlocProvider(create: (_) => getIt<AnalyticsBloc>()),
        BlocProvider(create: (_) => getIt<ExportBloc>()),
        BlocProvider(create: (_) => getIt<SettingsBloc>()..add(LoadSettings())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // standard design size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  return MaterialApp(
                    title: 'Expense Tracker',
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightThemeWithExtensions,
                    darkTheme: AppTheme.darkThemeWithExtensions,
                    themeMode: settingsState.themeMode,
                    home: authState is Authenticated
                        ? const MainNavigationPage()
                        : const LivenessGatePage(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Process recurring transactions on app launch (Phase 8.2.10)
    context.read<TransactionsBloc>().add(ProcessRecurringEvent());
  }

  final List<Widget> _pages = [
    const DashboardPage(),
    const TransactionsListPage(),
    const BudgetsPage(),
    const AnalyticsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Logs',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Budget'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Charts'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
