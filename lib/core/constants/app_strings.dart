/// UI strings for the Expense Tracker application.
///
/// This file contains all user-facing text strings used throughout the app.
/// Strings are organized by feature/screen for easy maintenance and localization.
class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  // ============================================================================
  // General / Common
  // ============================================================================

  static const String appName = 'Expense Tracker';
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String confirm = 'Confirm';
  static const String retry = 'Retry';
  static const String close = 'Close';
  static const String done = 'Done';
  static const String next = 'Next';
  static const String back = 'Back';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String all = 'All';
  static const String loading = 'Loading...';
  static const String noData = 'No data available';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String warning = 'Warning';
  static const String undo = 'Undo';
  static const String seeAll = 'See All';
  static const String apply = 'Apply';
  static const String reset = 'Reset';
  static const String share = 'Share';
  static const String export = 'Export';

  // ============================================================================
  // Authentication / Liveness Verification
  // ============================================================================

  static const String livenessTitle = 'Verify Your Identity';
  static const String livenessSubtitle =
      'Complete facial liveness verification to access your financial data';
  static const String livenessStartButton = 'Start Verification';
  static const String livenessVerifying = 'Verifying...';
  static const String livenessSuccess = 'Verification Successful!';
  static const String livenessFailure = 'Verification Failed';
  static const String livenessRetry = 'Try Again';
  static const String livenessLocked = 'Too Many Attempts';
  static const String livenessLockedMessage =
      'Please wait {seconds} seconds before trying again';
  static const String livenessInstructionLookStraight =
      'Look straight at the camera';
  static const String livenessInstructionTurnLeft = 'Turn your head left';
  static const String livenessInstructionTurnRight = 'Turn your head right';
  static const String livenessInstructionSmile = 'Smile';
  static const String livenessInstructionBlink = 'Blink your eyes';
  static const String livenessSecureAccess = 'Secure Access';
  static const String livenessProtectData =
      'Your financial data is protected by facial liveness verification';

  // ============================================================================
  // Dashboard
  // ============================================================================

  static const String dashboardTitle = 'Dashboard';
  static const String totalBalance = 'Total Balance';
  static const String currentBalance = 'Current Balance';
  static const String income = 'Income';
  static const String expense = 'Expense';
  static const String thisMonth = 'This Month';
  static const String budgets = 'Budgets';
  static const String recentTransactions = 'Recent Transactions';
  static const String quickAdd = 'Quick Add';
  static const String noBudgetsYet = 'No budgets set yet';
  static const String noTransactionsYet = 'No transactions yet';
  static const String addYourFirst = 'Add your first transaction';
  static const String setBudget = 'Set a budget';
  static const String viewAll = 'View All';
  static const String monthlyIncome = 'Monthly Income';
  static const String monthlyExpense = 'Monthly Expense';

  // ============================================================================
  // Transactions
  // ============================================================================

  static const String transactions = 'Transactions';
  static const String addTransaction = 'Add Transaction';
  static const String editTransaction = 'Edit Transaction';
  static const String transactionDetails = 'Transaction Details';
  static const String title = 'Title';
  static const String amount = 'Amount';
  static const String type = 'Type';
  static const String category = 'Category';
  static const String date = 'Date';
  static const String note = 'Note';
  static const String optional = 'Optional';
  static const String recurring = 'Recurring';
  static const String recurringInterval = 'Recurring Interval';
  static const String recurringEndDate = 'End Date';
  static const String noEndDate = 'No End Date';
  static const String daily = 'Daily';
  static const String weekly = 'Weekly';
  static const String monthly = 'Monthly';
  static const String yearly = 'Yearly';
  static const String incomeType = 'Income';
  static const String expenseType = 'Expense';
  static const String selectCategory = 'Select Category';
  static const String selectDate = 'Select Date';
  static const String enterTitle = 'Enter title';
  static const String enterAmount = 'Enter amount';
  static const String enterNote = 'Enter note (optional)';
  static const String saveTransaction = 'Save Transaction';
  static const String deleteTransaction = 'Delete Transaction';
  static const String transactionAdded = 'Transaction added successfully';
  static const String transactionUpdated = 'Transaction updated successfully';
  static const String transactionDeleted = 'Transaction deleted';
  static const String deleteTransactionConfirm =
      'Are you sure you want to delete this transaction?';
  static const String deleteRecurringConfirm =
      'Delete only this instance or all future instances?';
  static const String deleteOnlyThis = 'Only This';
  static const String deleteAllFuture = 'All Future';
  static const String filterByType = 'Filter by Type';
  static const String filterByCategory = 'Filter by Category';
  static const String filterByDate = 'Filter by Date';
  static const String searchTransactions = 'Search transactions...';
  static const String noTransactionsFound = 'No transactions found';
  static const String today = 'Today';
  static const String yesterday = 'Yesterday';
  static const String thisWeek = 'This Week';
  static const String thisYear = 'This Year';
  static const String custom = 'Custom';
  static const String startDate = 'Start Date';
  static const String endDate = 'End Date';
  static const String clearFilters = 'Clear Filters';

  // ============================================================================
  // Transaction Categories
  // ============================================================================

  static const String categoryFood = 'Food';
  static const String categoryTransport = 'Transport';
  static const String categoryShopping = 'Shopping';
  static const String categoryHealth = 'Health';
  static const String categoryEntertainment = 'Entertainment';
  static const String categoryEducation = 'Education';
  static const String categorySalary = 'Salary';
  static const String categoryFreelance = 'Freelance';
  static const String categoryInvestment = 'Investment';
  static const String categoryRent = 'Rent';
  static const String categoryUtilities = 'Utilities';
  static const String categoryTravel = 'Travel';
  static const String categoryOther = 'Other';

  // ============================================================================
  // Budget
  // ============================================================================

  static const String budget = 'Budget';
  static const String addBudget = 'Add Budget';
  static const String editBudget = 'Edit Budget';
  static const String budgetDetails = 'Budget Details';
  static const String limit = 'Limit';
  static const String period = 'Period';
  static const String spent = 'Spent';
  static const String remaining = 'Remaining';
  static const String daysLeft = 'days left';
  static const String onTrack = 'On Track';
  static const String exceeded = 'Exceeded';
  static const String budgetProgress = 'Budget Progress';
  static const String setBudgetLimit = 'Set Budget Limit';
  static const String selectPeriod = 'Select Period';
  static const String saveBudget = 'Save Budget';
  static const String deleteBudget = 'Delete Budget';
  static const String budgetAdded = 'Budget added successfully';
  static const String budgetUpdated = 'Budget updated successfully';
  static const String budgetDeleted = 'Budget deleted';
  static const String deleteBudgetConfirm =
      'Are you sure you want to delete this budget?';
  static const String noBudgetsFound = 'No budgets found';
  static const String createFirstBudget = 'Create your first budget';
  static const String budgetWarning = 'You are approaching your budget limit';
  static const String budgetExceeded = 'You have exceeded your budget limit';
  static const String of = 'of';

  // ============================================================================
  // Analytics
  // ============================================================================

  static const String analytics = 'Analytics';
  static const String spendingByCategory = 'Spending by Category';
  static const String incomeVsExpense = 'Income vs Expense';
  static const String balanceTrend = 'Balance Trend';
  static const String categoryBreakdown = 'Category Breakdown';
  static const String last6Months = 'Last 6 Months';
  static const String customRange = 'Custom Range';
  static const String noDataForPeriod = 'No data available for this period';
  static const String totalIncome = 'Total Income';
  static const String totalExpense = 'Total Expense';
  static const String netBalance = 'Net Balance';
  static const String percentage = 'Percentage';
  static const String trend = 'Trend';
  static const String comparison = 'Comparison';

  // ============================================================================
  // Export
  // ============================================================================

  static const String exportData = 'Export Data';
  static const String exportTitle = 'Export Your Data';
  static const String exportSubtitle = 'Generate reports in CSV or PDF format';
  static const String selectFormat = 'Select Format';
  static const String csvFormat = 'CSV';
  static const String pdfFormat = 'PDF';
  static const String selectDateRange = 'Select Date Range';
  static const String selectFilter = 'Select Filter';
  static const String incomeOnly = 'Income Only';
  static const String expenseOnly = 'Expense Only';
  static const String allTransactions = 'All Transactions';
  static const String generateReport = 'Generate Report';
  static const String exportSuccess = 'Export completed successfully';
  static const String exportError = 'Failed to export data';
  static const String exporting = 'Exporting...';
  static const String reportGenerated = 'Report Generated';
  static const String shareReport = 'Share Report';
  static const String saveReport = 'Save Report';

  // ============================================================================
  // Settings
  // ============================================================================

  static const String settings = 'Settings';
  static const String general = 'General';
  static const String appearance = 'Appearance';
  static const String data = 'Data';
  static const String about = 'About';
  static const String currency = 'Currency';
  static const String selectCurrency = 'Select Currency';
  static const String theme = 'Theme';
  static const String lightTheme = 'Light';
  static const String darkTheme = 'Dark';
  static const String systemTheme = 'System';
  static const String clearAllTransactions = 'Clear All Transactions';
  static const String clearAllBudgets = 'Clear All Budgets';
  static const String clearAllData = 'Clear All Data';
  static const String clearTransactionsConfirm =
      'Are you sure you want to delete all transactions? This action cannot be undone.';
  static const String clearBudgetsConfirm =
      'Are you sure you want to delete all budgets? This action cannot be undone.';
  static const String dataCleared = 'Data cleared successfully';
  static const String version = 'Version';
  static const String appVersion = 'App Version';
  static const String preferences = 'Preferences';
  static const String dataManagement = 'Data Management';

  // ============================================================================
  // Currencies
  // ============================================================================

  static const String currencyNGN = 'Nigerian Naira (₦)';
  static const String currencyUSD = r'US Dollar ($)';
  static const String currencyGBP = 'British Pound (£)';
  static const String currencyEUR = 'Euro (€)';
  static const String currencyGHS = 'Ghanaian Cedi (₵)';
  static const String currencyKES = 'Kenyan Shilling (KSh)';
  static const String currencyZAR = 'South African Rand (R)';

  // ============================================================================
  // Validation Messages
  // ============================================================================

  static const String titleRequired = 'Title is required';
  static const String amountRequired = 'Amount is required';
  static const String amountMustBePositive = 'Amount must be greater than zero';
  static const String categoryRequired = 'Category is required';
  static const String dateRequired = 'Date is required';
  static const String limitRequired = 'Limit is required';
  static const String limitMustBePositive = 'Limit must be greater than zero';
  static const String periodRequired = 'Period is required';
  static const String invalidAmount = 'Invalid amount';
  static const String invalidDate = 'Invalid date';
  static const String titleTooLong = 'Title is too long';
  static const String noteTooLong = 'Note is too long';

  // ============================================================================
  // Error Messages
  // ============================================================================

  static const String errorGeneric = 'An unexpected error occurred';
  static const String errorNetwork = 'Network connection failed';
  static const String errorStorage = 'Failed to access local storage';
  static const String errorValidation = 'Please check your input';
  static const String errorAuthentication = 'Authentication failed';
  static const String errorLoadingData = 'Failed to load data';
  static const String errorSavingData = 'Failed to save data';
  static const String errorDeletingData = 'Failed to delete data';
  static const String errorExporting = 'Failed to export data';
  static const String errorNoData = 'No data to export';
  static const String tryAgain = 'Please try again';

  // ============================================================================
  // Empty States
  // ============================================================================

  static const String emptyTransactionsTitle = 'No Transactions Yet';
  static const String emptyTransactionsMessage =
      'Start tracking your finances by adding your first transaction';
  static const String emptyBudgetsTitle = 'No Budgets Set';
  static const String emptyBudgetsMessage =
      'Set spending limits for different categories to manage your expenses';
  static const String emptyAnalyticsTitle = 'No Data Available';
  static const String emptyAnalyticsMessage =
      'Add transactions to see your spending patterns and trends';
  static const String emptySearchTitle = 'No Results Found';
  static const String emptySearchMessage =
      'Try adjusting your search or filters';

  // ============================================================================
  // Bottom Navigation
  // ============================================================================

  static const String navDashboard = 'Dashboard';
  static const String navTransactions = 'Transactions';
  static const String navAnalytics = 'Analytics';
  static const String navSettings = 'Settings';

  // ============================================================================
  // Dialogs & Confirmations
  // ============================================================================

  static const String confirmationTitle = 'Confirmation';
  static const String deleteTitle = 'Delete';
  static const String warningTitle = 'Warning';
  static const String areYouSure = 'Are you sure?';
  static const String cannotBeUndone = 'This action cannot be undone';
  static const String proceedQuestion = 'Do you want to proceed?';

  // ============================================================================
  // Time & Date
  // ============================================================================

  static const String selectTime = 'Select Time';
  static const String selectDateTime = 'Select Date & Time';
  static const String from = 'From';
  static const String to = 'To';
  static const String dateRange = 'Date Range';

  // ============================================================================
  // Hints & Placeholders
  // ============================================================================

  static const String hintSearchTransactions = 'Search by title or note...';
  static const String hintEnterTitle = 'e.g., Grocery shopping';
  static const String hintEnterAmount = '0.00';
  static const String hintEnterNote = 'Add a note (optional)';
  static const String hintSelectCategory = 'Choose a category';
  static const String hintSelectDate = 'Choose a date';

  // ============================================================================
  // Tooltips & Help Text
  // ============================================================================

  static const String tooltipAddTransaction = 'Add new transaction';
  static const String tooltipFilter = 'Filter transactions';
  static const String tooltipSearch = 'Search transactions';
  static const String tooltipExport = 'Export data';
  static const String tooltipDelete = 'Delete';
  static const String tooltipEdit = 'Edit';
  static const String helpRecurring =
      'Enable to automatically create this transaction at regular intervals';
  static const String helpBudgetPeriod = 'Choose how often your budget resets';
  static const String helpEndDate =
      'Leave empty for recurring transactions that never end';

  // ============================================================================
  // Status Messages
  // ============================================================================

  static const String statusSaving = 'Saving...';
  static const String statusDeleting = 'Deleting...';
  static const String statusLoading = 'Loading...';
  static const String statusProcessing = 'Processing...';
  static const String statusGenerating = 'Generating...';
  static const String statusComplete = 'Complete';

  // ============================================================================
  // Accessibility Labels
  // ============================================================================

  static const String a11yIncomeIcon = 'Income icon';
  static const String a11yExpenseIcon = 'Expense icon';
  static const String a11yCategoryIcon = 'Category icon';
  static const String a11yDeleteButton = 'Delete button';
  static const String a11yEditButton = 'Edit button';
  static const String a11yAddButton = 'Add button';
  static const String a11yBackButton = 'Back button';
  static const String a11yCloseButton = 'Close button';
  static const String a11yFilterButton = 'Filter button';
  static const String a11ySearchButton = 'Search button';

  // ============================================================================
  // Chart Labels
  // ============================================================================

  static const String chartNoData = 'No data to display';
  static const String chartLoading = 'Loading chart...';
  static const String chartError = 'Failed to load chart';
  static const String chartLegend = 'Legend';
  static const String chartTotal = 'Total';

  // ============================================================================
  // Recurring Transaction Labels
  // ============================================================================

  static const String recurringBadge = 'Recurring';
  static const String recurringDaily = 'Repeats daily';
  static const String recurringWeekly = 'Repeats weekly';
  static const String recurringMonthly = 'Repeats monthly';
  static const String recurringYearly = 'Repeats yearly';
  static const String nextOccurrence = 'Next occurrence';
  static const String lastOccurrence = 'Last occurrence';

  // ============================================================================
  // Budget Status Labels
  // ============================================================================

  static const String budgetStatusOnTrack = 'On Track';
  static const String budgetStatusWarning = 'Warning';
  static const String budgetStatusExceeded = 'Exceeded';
  static const String budgetStatusHealthy = 'Healthy';
  static const String budgetStatusCritical = 'Critical';

  // ============================================================================
  // Period Labels
  // ============================================================================

  static const String periodWeekly = 'Weekly';
  static const String periodMonthly = 'Monthly';
  static const String periodYearly = 'Yearly';
  static const String periodDaily = 'Daily';
  static const String periodCustom = 'Custom';

  // ============================================================================
  // Action Labels
  // ============================================================================

  static const String actionAdd = 'Add';
  static const String actionEdit = 'Edit';
  static const String actionDelete = 'Delete';
  static const String actionSave = 'Save';
  static const String actionCancel = 'Cancel';
  static const String actionConfirm = 'Confirm';
  static const String actionRetry = 'Retry';
  static const String actionShare = 'Share';
  static const String actionExport = 'Export';
  static const String actionFilter = 'Filter';
  static const String actionSearch = 'Search';
  static const String actionClear = 'Clear';
  static const String actionApply = 'Apply';
  static const String actionReset = 'Reset';
  static const String actionClose = 'Close';
  static const String actionUndo = 'Undo';
  static const String actionViewAll = 'View All';
  static const String actionSeeAll = 'See All';

  // ============================================================================
  // Form Labels
  // ============================================================================

  static const String formTitle = 'Title';
  static const String formAmount = 'Amount';
  static const String formType = 'Type';
  static const String formCategory = 'Category';
  static const String formDate = 'Date';
  static const String formNote = 'Note';
  static const String formRecurring = 'Recurring';
  static const String formInterval = 'Interval';
  static const String formEndDate = 'End Date';
  static const String formLimit = 'Limit';
  static const String formPeriod = 'Period';
  static const String formRequired = 'Required';
  static const String formOptional = 'Optional';
}
