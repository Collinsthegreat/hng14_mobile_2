# 💰 Expense Tracker App

A production-grade mobile expense tracker built with **Flutter** following **Clean Architecture** principles.

## ✨ Features
- **🔐 Liveness Verification**: Secure access with simulated liveness detection and lockout logic.
- **📊 Advanced Analytics**: Visualize spending trends with interactive Pie, Bar, and Line charts.
- **📅 Budget Management**: Set monthly limits per category and track progress with real-time status alerts.
- **🔄 Recurring Transactions**: Automatically process daily, weekly, or monthly repeating expenses.
- **📄 Data Export**: Generate and share CSV or PDF reports of your financial history.
- **🌓 Theme Engine**: Seamlessly switch between Light, Dark, and System themes.
- **💱 Multi-Currency**: Support for NGN, USD, EUR, GBP, and more.
- **💾 Offline First**: Local data persistence using high-performance Hive storage.

## 🏗️ Architecture
The project follows **Uncle Bob's Clean Architecture** with three distinct layers:

1. **Domain Layer**: Contains Business Logic, Entities, and Use Cases. Completely independent of frameworks.
2. **Data Layer**: Implements Repository interfaces, Data Sources (Hive, Secure Storage), and Models.
3. **Presentation Layer**: UI implementation using BLoC (Business Logic Component) for state management.

## 🛠️ Tech Stack
- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) & [injectable](https://pub.dev/packages/injectable)
- **Local Storage**: [Hive](https://pub.dev/packages/hive) & [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- **Charts**: [fl_chart](https://pub.dev/packages/fl_chart)
- **Theming**: [flex_color_scheme](https://pub.dev/packages/flex_color_scheme)
- **Testing**: [mocktail](https://pub.dev/packages/mocktail) & [bloc_test](https://pub.dev/packages/bloc_test)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Latest Stable)
- Android Studio / VS Code
- Android/iOS Device or Emulator

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/user/expense_tracker.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Generate boilerplate (DI & Hive):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## 🧪 Testing
Run all unit and BLoC tests:
```bash
flutter test
```

## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
