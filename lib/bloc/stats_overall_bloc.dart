import 'package:arithmetic_pvp/bloc/states/stats_overall_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/api.dart';
import '../data/models/overall_stats.dart';
import 'events/stats_overall_events.dart';

class StatsOverallBloc extends Bloc<StatsOverallEvent, StatsOverallState> {
  StatsOverallBloc() : super(StatsOverallStateLoading()) {
    final _api = GetIt.instance<Api>();

    on<StatsOverallEventLoad>((event, emit) async {
      emit(StatsOverallStateLoading());
      OverallStats? overallStats = await _api.getOverallStats();

      if (overallStats != null) {
        OverallStats? newOverallStats = OverallStats(
            matchesPlayed: overallStats.matchesPlayed,
            tasksSolved: overallStats.tasksSolved,
            rating: overallStats.rating,
            timeSpent: overallStats.timeSpent,
            avgTimePerTask:
                double.parse((overallStats.avgTimePerTask).toStringAsFixed(3)));
        final duration = Duration(seconds: overallStats.avgTimePerTask.round());
        String newOverallTime = "";
        if (duration.inDays != 0) {
          newOverallTime += "${duration.inDays} + D ";
        }
        if (duration.inHours != 0) {
          newOverallTime += "${duration.inHours} + H ";
        }
        if (duration.inMinutes != 0) {
          newOverallTime += "${duration.inMinutes} + m ";
        }
        if (duration.inSeconds != 0) {
          newOverallTime += "${duration.inSeconds} + s ";
        }
        if (newOverallTime == ""){
          newOverallTime += "0 s";
        }
        emit(StatsOverallStateLoaded(newOverallStats, newOverallTime));
      } else {
        emit(StatsOverallStateError());
      }
    });
  }
}
