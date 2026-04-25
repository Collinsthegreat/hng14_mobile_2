import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart'; // TODO: Add share_plus to pubspec once SDK issue is resolved
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/export_bloc.dart';
import '../bloc/export_event.dart';
import '../bloc/export_state.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  ExportFormat _selectedFormat = ExportFormat.pdf;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export Data')),
      body: BlocListener<ExportBloc, ExportState>(
        listener: (context, state) {
          if (state is ExportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Export successful! File saved at \${state.path}',
                ),
              ),
            );
            // TODO: Share the file using share_plus
            // Share.shareXFiles([XFile(state.path)]);
          } else if (state is ExportError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Export Format',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _buildFormatChip(ExportFormat.pdf, 'PDF Document'),
                  SizedBox(width: 12.w),
                  _buildFormatChip(ExportFormat.csv, 'CSV Spreadsheet'),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                'Select Date Range',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              _buildDateSelector(),
              const Spacer(),
              BlocBuilder<ExportBloc, ExportState>(
                builder: (context, state) {
                  return CustomButton(
                    text: 'Export Transactions',
                    isLoading: state is ExportLoading,
                    onPressed: () {
                      context.read<ExportBloc>().add(
                        ExportTransactions(
                          format: _selectedFormat,
                          start: _startDate,
                          end: _endDate,
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormatChip(ExportFormat format, String label) {
    final isSelected = _selectedFormat == format;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFormat = format;
          });
        }
      },
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildDateRow('Start Date', _startDate, (date) {
            setState(() => _startDate = date);
          }),
          Divider(height: 32.h),
          _buildDateRow('End Date', _endDate, (date) {
            setState(() => _endDate = date);
          }),
        ],
      ),
    );
  }

  Widget _buildDateRow(
    String label,
    DateTime date,
    Function(DateTime) onDateSelected,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16.sp)),
        TextButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              onDateSelected(selectedDate);
            }
          },
          child: Text(
            DateFormat('MMM dd, yyyy').format(date),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
