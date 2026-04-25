# Expense Tracker - Clean Architecture Structure

This document describes the folder structure and organization of the Expense Tracker application following Clean Architecture principles.

## Overview

The application is organized into three main directories:
- **core**: Shared utilities, constants, themes, and widgets
- **features**: Feature-specific code organized by Clean Architecture layers
- **config & injection**: App configuration and dependency injection

## Directory Structure

```
lib/
├── core/                          # Shared code across features
│   ├── constants/                 # App-wide constants (colors, strings, etc.)
│   ├── errors/                    # Error handling (failures, exceptions)
│   ├── theme/                     # Theme configuration (light/dark themes)
│   ├── utils/                     # Utility functions and helpers
│   └── widgets/                   # Reusable UI components
│
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   ├── data/
│   │   │   ├── datasources/       # SecureStorageDataSource
│   │   │   ├── models/            # Data models
│   │   │   └── repositories/      # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/          # Business entities
│   │   │   ├── repositories/      # Repository interfaces
│   │   │   └── usecases/          # Business logic (VerifyLiveness, CheckSession)
│   │   └── presentation/
│   │       ├── bloc/              # AuthBloc, AuthEvent, AuthState
│   │       ├── pages/             # LivenessGatePage
│   │       └── widgets/           # Auth-specific widgets
│   │
│   ├── transactions/              # Transaction management
│   │   ├── data/
│   │   │   ├── datasources/       # TransactionsLocalDataSource (Hive)
│   │   │   ├── models/            # TransactionModel with Hive adapters
│   │   │   └── repositories/      # TransactionsRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/          # TransactionEntity
│   │   │   ├── repositories/      # TransactionsRepository interface
│   │   │   └── usecases/          # GetAllTransactions, AddTransaction, etc.
│   │   └── presentation/
│   │       ├── bloc/              # TransactionsBloc
│   │       ├── pages/             # TransactionsListPage, TransactionFormPage
│   │       └── widgets/           # TransactionCard, TransactionFilters
│   │
│   ├── budget/                    # Budget management
│   │   ├── data/
│   │   │   ├── datasources/       # BudgetsLocalDataSource (Hive)
│   │   │   ├── models/            # BudgetModel with Hive adapters
│   │   │   └── repositories/      # BudgetsRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/          # BudgetEntity
│   │   │   ├── repositories/      # BudgetsRepository interface
│   │   │   └── usecases/          # GetAllBudgets, SetBudget, GetBudgetProgress
│   │   └── presentation/
│   │       ├── bloc/              # BudgetsBloc
│   │       ├── pages/             # BudgetsPage, BudgetFormPage
│   │       └── widgets/           # BudgetCard, BudgetProgressBar
│   │
│   ├── dashboard/                 # Dashboard feature
│   │   ├── data/
│   │   │   ├── datasources/       # Dashboard data aggregation
│   │   │   ├── models/            # DashboardSummaryModel
│   │   │   └── repositories/      # DashboardRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/          # DashboardSummaryEntity
│   │   │   ├── repositories/      # DashboardRepository interface
│   │   │   └── usecases/          # GetDashboardSummary
│   │   └── presentation/
│   │       ├── bloc/              # DashboardBloc
│   │       ├── pages/             # DashboardPage
│   │       └── widgets/           # BalanceCard, RecentTransactionsList
│   │
│   ├── analytics/                 # Analytics and charts
│   │   ├── data/
│   │   │   ├── datasources/       # Analytics data processing
│   │   │   ├── models/            # ChartDataModel
│   │   │   └── repositories/      # AnalyticsRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/          # ChartDataEntity
│   │   │   ├── repositories/      # AnalyticsRepository interface
│   │   │   └── usecases/          # GetSpendingByCategory, GetMonthlyTrend
│   │   └── presentation/
│   │       ├── bloc/              # AnalyticsBloc
│   │       ├── pages/             # AnalyticsPage
│   │       └── widgets/           # PieChart, BarChart, LineChart
│   │
│   ├── export/                    # Export functionality
│   │   ├── data/
│   │   │   ├── datasources/       # File system operations
│   │   │   ├── models/            # ExportConfigModel
│   │   │   └── repositories/      # ExportRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/          # ExportConfigEntity
│   │   │   ├── repositories/      # ExportRepository interface
│   │   │   └── usecases/          # ExportToCsv, ExportToPdf
│   │   └── presentation/
│   │       ├── bloc/              # ExportBloc
│   │       ├── pages/             # ExportPage
│   │       └── widgets/           # ExportOptions, FormatSelector
│   │
│   └── settings/                  # Settings feature
│       ├── data/
│       │   ├── datasources/       # SharedPreferences operations
│       │   ├── models/            # SettingsModel
│       │   └── repositories/      # SettingsRepositoryImpl
│       ├── domain/
│       │   ├── entities/          # SettingsEntity
│       │   ├── repositories/      # SettingsRepository interface
│       │   └── usecases/          # GetSettings, UpdateSettings
│       └── presentation/
│           ├── bloc/              # SettingsBloc
│           ├── pages/             # SettingsPage
│           └── widgets/           # ThemeSelector, CurrencySelector
│
├── config/                        # App configuration
│   └── routes.dart                # GoRouter configuration
│
├── injection/                     # Dependency injection
│   ├── injection_container.dart   # GetIt setup
│   └── injection_container.config.dart  # Generated by injectable
│
└── main.dart                      # App entry point
```

## Clean Architecture Layers

### 1. Domain Layer (Business Logic)
**Location**: `features/{feature}/domain/`

The innermost layer containing pure business logic with no external dependencies.

- **entities/**: Pure Dart classes representing business objects
  - Example: `TransactionEntity`, `BudgetEntity`
  - No annotations, no framework dependencies
  
- **repositories/**: Abstract interfaces defining data operations
  - Example: `abstract class TransactionsRepository`
  - Returns `Either<Failure, T>` for error handling
  
- **usecases/**: Single-responsibility business operations
  - Example: `AddTransaction`, `GetBudgetProgress`
  - Each use case has one public method: `call()`

### 2. Data Layer (Data Management)
**Location**: `features/{feature}/data/`

Handles data persistence and external data sources.

- **models/**: Serializable data classes
  - Example: `TransactionModel extends TransactionEntity`
  - Contains Hive TypeAdapters for local storage
  - Includes `toEntity()` and `fromEntity()` methods
  
- **datasources/**: Direct interaction with data sources
  - Example: `TransactionsLocalDataSource` (Hive operations)
  - Example: `SecureStorageDataSource` (flutter_secure_storage)
  
- **repositories/**: Concrete implementations of domain repositories
  - Example: `TransactionsRepositoryImpl implements TransactionsRepository`
  - Handles data source coordination and error mapping

### 3. Presentation Layer (UI)
**Location**: `features/{feature}/presentation/`

Manages UI and user interactions.

- **bloc/**: State management using BLoC pattern
  - `{feature}_bloc.dart`: Business logic component
  - `{feature}_event.dart`: User actions
  - `{feature}_state.dart`: UI states
  
- **pages/**: Full-screen widgets
  - Example: `DashboardPage`, `TransactionFormPage`
  - Contains BlocProvider and BlocBuilder
  
- **widgets/**: Reusable UI components
  - Example: `TransactionCard`, `BudgetProgressBar`
  - Stateless or stateful widgets

## Dependency Flow

```
Presentation → Domain ← Data
```

- **Presentation** depends on **Domain** (uses use cases and entities)
- **Data** depends on **Domain** (implements repository interfaces)
- **Domain** has NO dependencies (pure business logic)

## Core Directory

Shared code used across multiple features:

- **constants/**: App-wide constants
  - `app_colors.dart`: Color palette
  - `app_strings.dart`: Text constants
  - `app_sizes.dart`: Spacing and sizing
  
- **errors/**: Error handling
  - `failures.dart`: Abstract failure classes
  - `exceptions.dart`: Exception definitions
  
- **theme/**: Theme configuration
  - `app_theme.dart`: Light and dark themes
  - `text_styles.dart`: Typography definitions
  
- **utils/**: Helper functions
  - `date_formatter.dart`: Date formatting utilities
  - `currency_formatter.dart`: Currency formatting
  - `validators.dart`: Input validation
  
- **widgets/**: Reusable components
  - `custom_button.dart`: Styled buttons
  - `loading_indicator.dart`: Loading states
  - `error_widget.dart`: Error displays

## Dependency Injection

**Location**: `lib/injection/`

Uses `get_it` and `injectable` for dependency management:

```dart
// injection_container.dart
final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

// Usage in main.dart
void main() async {
  configureDependencies();
  runApp(MyApp());
}
```

## Navigation

**Location**: `lib/config/routes.dart`

Uses `go_router` for declarative routing:

```dart
final router = GoRouter(
  initialLocation: '/liveness',
  routes: [
    GoRoute(path: '/liveness', builder: LivenessGatePage),
    GoRoute(path: '/dashboard', builder: DashboardPage),
    // ... more routes
  ],
);
```

## Testing Structure

Tests mirror the lib structure:

```
test/
├── core/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── transactions/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── helpers/
    └── test_helper.dart
```

## Key Principles

1. **Separation of Concerns**: Each layer has a distinct responsibility
2. **Dependency Inversion**: High-level modules don't depend on low-level modules
3. **Single Responsibility**: Each class/file has one reason to change
4. **Testability**: Pure business logic is easy to unit test
5. **Scalability**: New features follow the same structure

## Adding a New Feature

To add a new feature:

1. Create feature directory: `lib/features/{feature_name}/`
2. Create three layer directories: `data/`, `domain/`, `presentation/`
3. Create subdirectories in each layer
4. Implement domain layer first (entities, repositories, use cases)
5. Implement data layer (models, data sources, repository implementations)
6. Implement presentation layer (BLoC, pages, widgets)
7. Register dependencies in `injection_container.dart`
8. Add routes in `config/routes.dart`

## Code Generation

Run after creating models or updating dependencies:

```bash
# Generate Hive adapters, injectable, etc.
dart run build_runner build --delete-conflicting-outputs

# Watch mode for development
dart run build_runner watch --delete-conflicting-outputs
```

## References

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Pattern](https://bloclibrary.dev/)
- [Dependency Injection in Flutter](https://pub.dev/packages/get_it)
