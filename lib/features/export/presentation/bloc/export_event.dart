import 'package:equatable/equatable.dart';

enum ExportFormat { csv, pdf }

abstract class ExportEvent extends Equatable {
  const ExportEvent();

  @override
  List<Object?> get props => [];
}

class ExportTransactions extends ExportEvent {
  final ExportFormat format;
  final DateTime start;
  final DateTime end;

  const ExportTransactions({
    required this.format,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [format, start, end];
}
