import 'package:equatable/equatable.dart';

enum AnalyticsPeriod { thisWeek, thisMonth, thisYear, custom }

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAnalyticsData extends AnalyticsEvent {
  final AnalyticsPeriod period;
  final DateTime? start;
  final DateTime? end;

  const LoadAnalyticsData({required this.period, this.start, this.end});

  @override
  List<Object?> get props => [period, start, end];
}
