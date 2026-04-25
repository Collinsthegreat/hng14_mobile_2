import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardData extends DashboardEvent {}

class ChangeDashboardDateRange extends DashboardEvent {
  final DateTime startDate;
  final DateTime endDate;

  const ChangeDashboardDateRange(this.startDate, this.endDate);

  @override
  List<Object?> get props => [startDate, endDate];
}
