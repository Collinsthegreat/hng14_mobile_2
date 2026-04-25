import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';

class SettingsState extends Equatable {
  final Currency currency;
  final ThemeMode themeMode;
  final bool isLoading;
  final String? error;

  const SettingsState({
    this.currency = Currency.ngn,
    this.themeMode = ThemeMode.system,
    this.isLoading = false,
    this.error,
  });

  SettingsState copyWith({
    Currency? currency,
    ThemeMode? themeMode,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      currency: currency ?? this.currency,
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [currency, themeMode, isLoading, error];
}
