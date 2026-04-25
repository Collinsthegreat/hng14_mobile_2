import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(16.r),
            children: [
              _buildSectionTitle('Appearance'),
              ListTile(
                title: const Text('Theme Mode'),
                subtitle: Text(_getThemeName(state.themeMode)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showThemeDialog(context, state.themeMode),
              ),
              const Divider(),
              _buildSectionTitle('Localization'),
              ListTile(
                title: const Text('Currency'),
                subtitle: Text(state.currency.name.toUpperCase()),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showCurrencyDialog(context, state.currency),
              ),
              const Divider(),
              _buildSectionTitle('Data Management'),
              ListTile(
                title: const Text(
                  'Clear All Data',
                  style: TextStyle(color: Colors.red),
                ),
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                onTap: () => _showClearDataDialog(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System Default';
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
    }
  }

  void _showThemeDialog(BuildContext context, ThemeMode currentMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((mode) {
            return RadioListTile<ThemeMode>(
              title: Text(_getThemeName(mode)),
              value: mode,
              groupValue: currentMode,
              onChanged: (value) {
                if (value != null) {
                  context.read<SettingsBloc>().add(ChangeTheme(value));
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context, Currency currentCurrency) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Currency'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: Currency.values.length,
            itemBuilder: (context, index) {
              final currency = Currency.values[index];
              return RadioListTile<Currency>(
                title: Text(currency.name.toUpperCase()),
                value: currency,
                groupValue: currentCurrency,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SettingsBloc>().add(ChangeCurrency(value));
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This action cannot be undone. All your transactions and budgets will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<SettingsBloc>().add(ClearAllData());
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
