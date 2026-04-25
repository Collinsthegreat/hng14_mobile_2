import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/export_to_csv.dart';
import '../../domain/usecases/export_to_pdf.dart';
import 'export_event.dart';
import 'export_state.dart';

@injectable
class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final ExportToCsv exportToCsv;
  final ExportToPdf exportToPdf;

  ExportBloc({required this.exportToCsv, required this.exportToPdf})
    : super(ExportInitial()) {
    on<ExportTransactions>(_onExportTransactions);
  }

  Future<void> _onExportTransactions(
    ExportTransactions event,
    Emitter<ExportState> emit,
  ) async {
    emit(ExportLoading());

    final result = event.format == ExportFormat.csv
        ? await exportToCsv(start: event.start, end: event.end)
        : await exportToPdf(start: event.start, end: event.end);

    result.fold(
      (failure) => emit(ExportError(failure.message)),
      (path) => emit(ExportSuccess(path: path, format: event.format)),
    );
  }
}
