import 'package:equatable/equatable.dart';
import 'export_event.dart';

abstract class ExportState extends Equatable {
  const ExportState();

  @override
  List<Object?> get props => [];
}

class ExportInitial extends ExportState {
  const ExportInitial();
}

class ExportLoading extends ExportState {
  const ExportLoading();
}

class ExportSuccess extends ExportState {
  final String path;
  final ExportFormat format;

  const ExportSuccess({required this.path, required this.format});

  @override
  List<Object?> get props => [path, format];
}

class ExportError extends ExportState {
  final String message;

  const ExportError(this.message);

  @override
  List<Object?> get props => [message];
}
