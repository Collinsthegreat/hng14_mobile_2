import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/dashboard/domain/entities/dashboard_summary_entity.dart';
import 'package:expense_tracker/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:expense_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:expense_tracker/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:expense_tracker/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDashboardSummary extends Mock implements GetDashboardSummary {}

void main() {
  late DashboardBloc bloc;
  late MockGetDashboardSummary mockGetSummary;

  setUp(() {
    mockGetSummary = MockGetDashboardSummary();
    bloc = DashboardBloc(getDashboardSummary: mockGetSummary);
  });

  tearDown(() => bloc.close());

  final tSummary = DashboardSummaryEntity(
    totalBalance: 1000.0,
    currentMonthIncome: 1500.0,
    currentMonthExpense: 500.0,
    recentTransactions: [],
    activeBudgets: [],
  );

  group('DashboardBloc', () {
    test('initial state is DashboardInitial', () {
      expect(bloc.state, const DashboardInitial());
    });

    blocTest<DashboardBloc, DashboardState>(
      'emits [DashboardLoading, DashboardLoaded] when LoadDashboardData is successful',
      build: () {
        when(() => mockGetSummary()).thenAnswer((_) async => Right(tSummary));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadDashboardData()),
      expect: () => [
        const DashboardLoading(),
        DashboardLoaded(summary: tSummary),
      ],
    );
  });
}
