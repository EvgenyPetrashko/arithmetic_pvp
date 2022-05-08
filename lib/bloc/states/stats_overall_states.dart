import 'package:arithmetic_pvp/data/models/overall_stats.dart';

abstract class StatsOverallState {}

class StatsOverallStateLoading extends StatsOverallState {}

class StatsOverallStateLoaded extends StatsOverallState {
  final String strOverallTime;
  final OverallStats overallStats;

  StatsOverallStateLoaded(this.overallStats, this.strOverallTime);
}

class StatsOverallStateError extends StatsOverallState {}
