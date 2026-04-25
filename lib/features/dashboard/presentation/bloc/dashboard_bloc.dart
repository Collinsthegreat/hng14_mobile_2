import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_dashboard_summary.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardSummary getDashboardSummary;

  DashboardBloc({required this.getDashboardSummary})
    : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await getDashboardSummary();

    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (summary) => emit(DashboardLoaded(summary: summary)),
    );
  }
}
