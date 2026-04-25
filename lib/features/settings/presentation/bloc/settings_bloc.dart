import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../budget/domain/repositories/budget_repository.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';
import '../../../../core/utils/currency_formatter.dart';
import 'settings_event.dart';
import 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final FlutterSecureStorage secureStorage;
  final BudgetRepository budgetRepository;
  final TransactionsRepository transactionsRepository;

  SettingsBloc({
    required this.secureStorage,
    required this.budgetRepository,
    required this.transactionsRepository,
  }) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ChangeCurrency>(_onChangeCurrency);
    on<ChangeTheme>(_onChangeTheme);
    on<ClearAllData>(_onClearAllData);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final currencyCode = await secureStorage.read(key: 'currency_code');
    final themeValue = await secureStorage.read(key: 'theme_mode');

    Currency currency = Currency.ngn;
    if (currencyCode != null) {
      currency = Currency.values.firstWhere(
        (c) => c.name == currencyCode,
        orElse: () => Currency.ngn,
      );
    }

    ThemeMode themeMode = ThemeMode.system;
    if (themeValue != null) {
      themeMode = ThemeMode.values.firstWhere(
        (t) => t.name == themeValue,
        orElse: () => ThemeMode.system,
      );
    }

    emit(
      state.copyWith(
        currency: currency,
        themeMode: themeMode,
        isLoading: false,
      ),
    );
  }

  Future<void> _onChangeCurrency(
    ChangeCurrency event,
    Emitter<SettingsState> emit,
  ) async {
    await secureStorage.write(key: 'currency_code', value: event.currency.name);
    emit(state.copyWith(currency: event.currency));
  }

  Future<void> _onChangeTheme(
    ChangeTheme event,
    Emitter<SettingsState> emit,
  ) async {
    await secureStorage.write(key: 'theme_mode', value: event.themeMode.name);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onClearAllData(
    ClearAllData event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // Logic to clear all data from repositories would go here
      // For now we'll assume the repositories have a clear method or similar
      // Or we just clear the boxes directly if we have access.

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to clear data: \${e.toString()}',
        ),
      );
    }
  }
}
