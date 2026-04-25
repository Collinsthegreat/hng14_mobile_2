/// App-wide constants for the Expense Tracker application.
///
/// This file contains all constant values used throughout the app including
/// app metadata, timeouts, limits, and configuration values.
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // ============================================================================
  // App Metadata
  // ============================================================================

  /// The application name
  static const String appName = 'Expense Tracker';

  /// The current application version
  static const String appVersion = '1.0.0';

  /// The build number
  static const int buildNumber = 1;

  // ============================================================================
  // Authentication & Security
  // ============================================================================

  /// Maximum number of consecutive liveness verification failures before lockout
  static const int maxVerificationAttempts = 3;

  /// Lockout duration in seconds after max verification attempts
  static const int verificationLockoutDuration = 30;

  /// Secure storage key for liveness verification session
  static const String livenessSessionKey = 'liveness_verified';

  // ============================================================================
  // Storage Configuration
  // ============================================================================

  /// Hive box name for transactions
  static const String transactionsBoxName = 'transactions_box';

  /// Hive box name for budgets
  static const String budgetsBoxName = 'budgets_box';

  /// Hive box name for settings
  static const String settingsBoxName = 'settings_box';

  // ============================================================================
  // Hive Type IDs
  // ============================================================================

  /// Type ID for TransactionModel
  static const int transactionModelTypeId = 0;

  /// Type ID for BudgetModel
  static const int budgetModelTypeId = 1;

  /// Type ID for TransactionType enum
  static const int transactionTypeEnumTypeId = 2;

  /// Type ID for TransactionCategory enum
  static const int transactionCategoryEnumTypeId = 3;

  /// Type ID for RecurringInterval enum
  static const int recurringIntervalEnumTypeId = 4;

  /// Type ID for BudgetPeriod enum
  static const int budgetPeriodEnumTypeId = 5;

  // ============================================================================
  // SharedPreferences Keys
  // ============================================================================

  /// Key for currency preference
  static const String currencyKey = 'currency';

  /// Key for theme mode preference
  static const String themeModeKey = 'theme_mode';

  /// Key for app version in settings
  static const String appVersionKey = 'app_version';

  // ============================================================================
  // UI Configuration
  // ============================================================================

  /// Number of recent transactions to display on dashboard
  static const int recentTransactionsLimit = 5;

  /// Duration for undo action after deletion (in seconds)
  static const int undoDuration = 5;

  /// Number of months to display in analytics charts
  static const int analyticsMonthsCount = 6;

  /// Design size width for responsive scaling (iPhone 11 Pro)
  static const double designWidth = 375.0;

  /// Design size height for responsive scaling (iPhone 11 Pro)
  static const double designHeight = 812.0;

  // ============================================================================
  // Animation Durations (in milliseconds)
  // ============================================================================

  /// Standard page transition duration
  static const int pageTransitionDuration = 300;

  /// Number counter animation duration
  static const int counterAnimationDuration = 1000;

  /// Fade in animation duration
  static const int fadeInDuration = 300;

  /// Chart rendering animation duration
  static const int chartAnimationDuration = 800;

  // ============================================================================
  // Budget Thresholds
  // ============================================================================

  /// Budget warning threshold percentage (70%)
  static const double budgetWarningThreshold = 0.70;

  /// Budget exceeded threshold percentage (90%)
  static const double budgetExceededThreshold = 0.90;

  // ============================================================================
  // Validation Limits
  // ============================================================================

  /// Minimum transaction amount
  static const double minTransactionAmount = 0.01;

  /// Maximum transaction amount
  static const double maxTransactionAmount = 999999999.99;

  /// Minimum budget limit amount
  static const double minBudgetAmount = 0.01;

  /// Maximum budget limit amount
  static const double maxBudgetAmount = 999999999.99;

  /// Maximum title length for transactions
  static const int maxTitleLength = 100;

  /// Maximum note length for transactions
  static const int maxNoteLength = 500;

  // ============================================================================
  // Date & Time Formats
  // ============================================================================

  /// Standard date format (e.g., 2024-01-15)
  static const String dateFormat = 'yyyy-MM-dd';

  /// Display date format (e.g., Jan 15, 2024)
  static const String displayDateFormat = 'MMM dd, yyyy';

  /// Month year format (e.g., January 2024)
  static const String monthYearFormat = 'MMMM yyyy';

  /// Time format (e.g., 14:30)
  static const String timeFormat = 'HH:mm';

  /// Full date time format (e.g., 2024-01-15 14:30:00)
  static const String fullDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // ============================================================================
  // Export Configuration
  // ============================================================================

  /// CSV file name prefix
  static const String csvFilePrefix = 'expense_tracker_export';

  /// PDF file name prefix
  static const String pdfFilePrefix = 'expense_tracker_report';

  /// CSV file extension
  static const String csvFileExtension = '.csv';

  /// PDF file extension
  static const String pdfFileExtension = '.pdf';

  // ============================================================================
  // Network & Timeout Configuration
  // ============================================================================

  /// Default timeout for operations (in seconds)
  static const int defaultTimeout = 30;

  /// Connection timeout (in seconds)
  static const int connectionTimeout = 15;

  /// Receive timeout (in seconds)
  static const int receiveTimeout = 15;

  // ============================================================================
  // Pagination & Limits
  // ============================================================================

  /// Default page size for paginated lists
  static const int defaultPageSize = 20;

  /// Maximum items to load at once
  static const int maxLoadItems = 100;

  // ============================================================================
  // Debounce Durations (in milliseconds)
  // ============================================================================

  /// Search input debounce duration
  static const int searchDebounceDuration = 500;

  /// Filter change debounce duration
  static const int filterDebounceDuration = 300;

  // ============================================================================
  // Asset Paths
  // ============================================================================

  /// Lottie animations directory
  static const String lottieAssetsPath = 'assets/lottie';

  /// Empty state animation
  static const String emptyStateAnimation = '$lottieAssetsPath/empty.json';

  /// Error state animation
  static const String errorStateAnimation = '$lottieAssetsPath/error.json';

  /// Success animation
  static const String successAnimation = '$lottieAssetsPath/success.json';

  /// Loading animation
  static const String loadingAnimation = '$lottieAssetsPath/loading.json';

  // ============================================================================
  // Route Paths
  // ============================================================================

  /// Liveness verification route
  static const String livenessRoute = '/liveness';

  /// Dashboard route
  static const String dashboardRoute = '/dashboard';

  /// Transactions list route
  static const String transactionsRoute = '/transactions';

  /// Add transaction route
  static const String addTransactionRoute = '/transactions/add';

  /// Edit transaction route (requires :id parameter)
  static const String editTransactionRoute = '/transactions/edit';

  /// Budgets list route
  static const String budgetsRoute = '/budgets';

  /// Add budget route
  static const String addBudgetRoute = '/budgets/add';

  /// Edit budget route (requires :id parameter)
  static const String editBudgetRoute = '/budgets/edit';

  /// Analytics route
  static const String analyticsRoute = '/analytics';

  /// Export route
  static const String exportRoute = '/export';

  /// Settings route
  static const String settingsRoute = '/settings';

  // ============================================================================
  // Error Messages
  // ============================================================================

  /// Generic error message
  static const String genericErrorMessage = 'An unexpected error occurred';

  /// Network error message
  static const String networkErrorMessage = 'Network connection failed';

  /// Storage error message
  static const String storageErrorMessage = 'Failed to access local storage';

  /// Validation error message
  static const String validationErrorMessage = 'Please check your input';

  /// Authentication error message
  static const String authenticationErrorMessage = 'Authentication failed';

  // ============================================================================
  // Success Messages
  // ============================================================================

  /// Transaction added success message
  static const String transactionAddedMessage =
      'Transaction added successfully';

  /// Transaction updated success message
  static const String transactionUpdatedMessage =
      'Transaction updated successfully';

  /// Transaction deleted success message
  static const String transactionDeletedMessage =
      'Transaction deleted successfully';

  /// Budget added success message
  static const String budgetAddedMessage = 'Budget added successfully';

  /// Budget updated success message
  static const String budgetUpdatedMessage = 'Budget updated successfully';

  /// Budget deleted success message
  static const String budgetDeletedMessage = 'Budget deleted successfully';

  /// Export success message
  static const String exportSuccessMessage = 'Export completed successfully';

  // ============================================================================
  // Confirmation Messages
  // ============================================================================

  /// Delete transaction confirmation
  static const String deleteTransactionConfirmation =
      'Are you sure you want to delete this transaction?';

  /// Delete budget confirmation
  static const String deleteBudgetConfirmation =
      'Are you sure you want to delete this budget?';

  /// Clear all transactions confirmation
  static const String clearAllTransactionsConfirmation =
      'Are you sure you want to delete all transactions? This action cannot be undone.';

  /// Clear all budgets confirmation
  static const String clearAllBudgetsConfirmation =
      'Are you sure you want to delete all budgets? This action cannot be undone.';

  /// Delete recurring transaction confirmation
  static const String deleteRecurringConfirmation =
      'Do you want to delete only this instance or all future instances?';
}
