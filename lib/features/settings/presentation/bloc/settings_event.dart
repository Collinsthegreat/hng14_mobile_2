import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ChangeCurrency extends SettingsEvent {
  final Currency currency;

  const ChangeCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}

class ChangeTheme extends SettingsEvent {
  final ThemeMode themeMode;

  const ChangeTheme(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ClearAllData extends SettingsEvent {}
