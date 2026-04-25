# Expense Tracker - Complete Folder Structure

## Created Structure

The following Clean Architecture folder structure has been created for the Expense Tracker application:

```
expense_tracker/lib/
│
├── main.dart                                    # Application entry point
│
├── config/                                      # Application configuration
│   └── .gitkeep
│
├── injection/                                   # Dependency injection setup
│   └── .gitkeep
│
├── core/                                        # Shared utilities and components
│   ├── constants/                               # App-wide constants
│   │   └── .gitkeep
│   ├── errors/                                  # Error handling (failures, exceptions)
│   │   └── .gitkeep
│   ├── theme/                                   # Theme configuration
│   │   └── .gitkeep
│   ├── utils/                                   # Helper functions
│   │   └── .gitkeep
│   └── widgets/                                 # Reusable UI components
│       └── .gitkeep
│
└── features/                                    # Feature modules
    │
    ├── auth/                                    # Authentication feature
    │   ├── data/
    │   │   ├── datasources/                     # SecureStorageDataSource
    │   │   │   └── .gitkeep
    │   │   ├── models/                          # Data models
    │   │   │   └── .gitkeep
    │   │   └── repositories/                    # Repository implementations
    │   │       └── .gitkeep
    │   ├── domain/
    │   │   ├── entities/                        # Business entities
    │   │   │   └── .gitkeep
    │   │   ├── repositories/                    # Repository interfaces
    │   │   │   └── .gitkeep
    │   │   └── usecases/                        # VerifyLiveness, CheckSession
    │   │       └── .gitkeep
    │   └── presentation/
    │       ├── bloc/                            # AuthBloc, AuthEvent, AuthState
    │       │   └── .gitkeep
    │       ├── pages/                           # LivenessGatePage
    │       │   └── .gitkeep
    │       └── widgets/                         # Auth-specific widgets
    │           └── .gitkeep
    │
    ├── transactions/                            # Transaction management
    │   ├── data/
    │   │   ├── datasources/                     # TransactionsLocalDataSource (Hive)
    │   │   │   └── .gitkeep
    │   │   ├── models/                          # TransactionModel with Hive adapters
    │   │   │   └── .gitkeep
    │   │   └── repositories/                    # TransactionsRepositoryImpl
    │   │       └── .gitkeep
    │   ├── domain/
    │   │   ├── entities/                        # TransactionEntity
    │   │   │   └── .gitkeep
    │   │   ├── repositories/                    # TransactionsRepository interface
    │   │   │   └── .gitkeep
    │   │   └── usecases/                        # GetAllTransactions, AddTransaction, etc.
    │   │       └── .gitkeep
    │   └── presentation/
    │       ├── bloc/                            # TransactionsBloc
    │       │   └── .gitkeep
    │       ├── pages/                           # TransactionsListPage, TransactionFormPage
    │       │   └── .gitkeep
    │       └── widgets/                         # TransactionCard, TransactionFilters
    │           └── .gitkeep
    │
    ├── budget/                                  # Budget management
    │   ├── data/
    │   │   ├── datasources/                     # BudgetsLocalDataSource (Hive)
    │   │   │   └── .gitkeep
    │   │   ├── models/                          # BudgetModel with Hive adapters
    │   │   │   └── .gitkeep
    │   │   └── repositories/                    # BudgetsRepositoryImpl
    │   │       └── .gitkeep
    │   ├── domain/
    │   │   ├── entities/                        # BudgetEntity
    │   │   │   └── .gitkeep
    │   │   ├── repositories/                    # BudgetsRepository interface
    │   │   │   └── .gitkeep
    │   │   └── usecases/                        # GetAllBudgets, SetBudget, GetBudgetProgress
    │   │       └── .gitkeep
    │   └── presentation/
    │       ├── bloc/                            # BudgetsBloc
    │       │   └── .gitkeep
    │       ├── pages/                           # BudgetsPage, BudgetFormPage
    │       │   └── .gitkeep
    │       └── widgets/                         # BudgetCard, BudgetProgressBar
    │           └── .gitkeep
    │
    ├── dashboard/                               # Dashboard feature
    │   ├── data/
    │   │   ├── datasources/                     # Dashboard data aggregation
    │   │   │   └── .gitkeep
    │   │   ├── models/                          # DashboardSummaryModel
    │   │   │   └── .gitkeep
    │   │   └── repositories/                    # DashboardRepositoryImpl
    │   │       └── .gitkeep
    │   ├── domain/
    │   │   ├── entities/                        # DashboardSummaryEntity
    │   │   │   └── .gitkeep
    │   │   ├── repositories/                    # DashboardRepository interface
    │   │   │   └── .gitkeep
    │   │   └── usecases/                        # GetDashboardSummary
    │   │       └── .gitkeep
    │   └── presentation/
    │       ├── bloc/                            # DashboardBloc
    │       │   └── .gitkeep
    │       ├── pages/                           # DashboardPage
    │       │   └── .gitkeep
    │       └── widgets/                         # BalanceCard, RecentTransactionsList
    │           └── .gitkeep
    │
    ├── analytics/                               # Analytics and charts
    │   ├── data/
    │   │   ├── datasources/                     # Analytics data processing
    │   │   │   └── .gitkeep
    │   │   ├── models/                          # ChartDataModel
    │   │   │   └── .gitkeep
    │   │   └── repositories/                    # AnalyticsRepositoryImpl
    │   │       └── .gitkeep
    │   ├── domain/
    │   │   ├── entities/                        # ChartDataEntity
    │   │   │   └── .gitkeep
    │   │   ├── repositories/                    # AnalyticsRepository interface
    │   │   │   └── .gitkeep
    │   │   └── usecases/                        # GetSpendingByCategory, GetMonthlyTrend
    │   │       └── .gitkeep
    │   └── presentation/
    │       ├── bloc/                            # AnalyticsBloc
    │       │   └── .gitkeep
    │       ├── pages/                           # AnalyticsPage
    │       │   └── .gitkeep
    │       └── widgets/                         # PieChart, BarChart, LineChart
    │           └── .gitkeep
    │
    ├── export/                                  # Export functionality
    │   ├── data/
    │   │   ├── datasources/                     # File system operations
    │   │   │   └── .gitkeep
    │   │   ├── models/                          # ExportConfigModel
    │   │   │   └── .gitkeep
    │   │   └── repositories/                    # ExportRepositoryImpl
    │   │       └── .gitkeep
    │   ├── domain/
    │   │   ├── entities/                        # ExportConfigEntity
    │   │   │   └── .gitkeep
    │   │   ├── repositories/                    # ExportRepository interface
    │   │   │   └── .gitkeep
    │   │   └── usecases/                        # ExportToCsv, ExportToPdf
    │   │       └── .gitkeep
    │   └── presentation/
    │       ├── bloc/                            # ExportBloc
    │       │   └── .gitkeep
    │       ├── pages/                           # ExportPage
    │       │   └── .gitkeep
    │       └── widgets/                         # ExportOptions, FormatSelector
    │           └── .gitkeep
    │
    └── settings/                                # Settings feature
        ├── data/
        │   ├── datasources/                     # SharedPreferences operations
        │   │   └── .gitkeep
        │   ├── models/                          # SettingsModel
        │   │   └── .gitkeep
        │   └── repositories/                    # SettingsRepositoryImpl
        │       └── .gitkeep
        ├── domain/
        │   ├── entities/                        # SettingsEntity
        │   │   └── .gitkeep
        │   ├── repositories/                    # SettingsRepository interface
        │   │   └── .gitkeep
        │   └── usecases/                        # GetSettings, UpdateSettings
        │       └── .gitkeep
        └── presentation/
            ├── bloc/                            # SettingsBloc
            │   └── .gitkeep
            ├── pages/                           # SettingsPage
            │   └── .gitkeep
            └── widgets/                         # ThemeSelector, CurrencySelector
                └── .gitkeep
```

## Summary

### Total Directories Created: 80+

#### Core (5 directories)
- constants, errors, theme, utils, widgets

#### Features (7 features × ~9 directories each)
1. **auth** - Authentication with liveness verification
2. **transactions** - Transaction management (CRUD operations)
3. **budget** - Budget tracking and progress monitoring
4. **dashboard** - Main dashboard with summaries
5. **analytics** - Charts and data visualization
6. **export** - CSV/PDF export functionality
7. **settings** - App settings and preferences

#### Each feature follows Clean Architecture:
- **data/** - datasources, models, repositories
- **domain/** - entities, repositories (interfaces), usecases
- **presentation/** - bloc, pages, widgets

#### Additional directories:
- **config/** - App configuration (routes, etc.)
- **injection/** - Dependency injection setup

## Clean Architecture Principles Applied

### Dependency Flow
```
Presentation Layer → Domain Layer ← Data Layer
```

### Layer Responsibilities

**Domain Layer (Business Logic)**
- Pure Dart code, no framework dependencies
- Contains entities, repository interfaces, and use cases
- Independent and testable

**Data Layer (Data Management)**
- Implements domain repository interfaces
- Handles data sources (Hive, SecureStorage, SharedPreferences)
- Contains models with serialization logic

**Presentation Layer (UI)**
- BLoC for state management
- Pages for full screens
- Widgets for reusable components
- Depends only on domain layer

