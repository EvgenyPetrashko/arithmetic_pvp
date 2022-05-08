import 'package:animated_background/animated_background.dart';
import 'package:arithmetic_pvp/bloc/stats_overall_bloc.dart';
import 'package:arithmetic_pvp/presentation/utils/rain_particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../bloc/events/stats_overall_events.dart';
import '../../bloc/states/stats_overall_states.dart';
import 'stats_appbar_overall.dart';

class OverallStatsPage extends StatefulWidget {
  const OverallStatsPage({Key? key}) : super(key: key);

  @override
  State<OverallStatsPage> createState() => _OverallStatsPageState();
}

class _OverallStatsPageState extends State<OverallStatsPage>
    with SingleTickerProviderStateMixin {
  final _statsOverallBloc = StatsOverallBloc();
  int rating = 0;
  int matchesPlayed = 0;
  int solvedProblems = 0;
  String timeSpent = "";
  double averageTime = 0.0;
  bool loading = false;

  _handleState(context, state) {
    bool _loading = false;
    if (state is StatsOverallStateLoading) {
      _loading = true;
    } else if (state is StatsOverallStateLoaded) {
      final _overallStats = state.overallStats;
      setState(() {
        rating = _overallStats.rating;
        matchesPlayed = _overallStats.matchesPlayed;
        solvedProblems = _overallStats.tasksSolved;
        timeSpent = state.strOverallTime;
        averageTime = _overallStats.avgTimePerTask;
      });
    } else if (state is StatsOverallStateError) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please try again later"),
        ),
      );
    }

    setState(() {
      if (loading != _loading) {
        loading = _loading;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _statsOverallBloc.add(StatsOverallEventLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatsAppBarOverall(),
      body: LoadingOverlay(
        isLoading: loading,
        color: Colors.black45,
        progressIndicator: JumpingText(
          '···',
          style: const TextStyle(fontSize: 60),
        ),
        child: SafeArea(
          child: AnimatedBackground(
            behaviour: RainParticleBehaviour(
              options: ParticleOptions(
                baseColor: Theme.of(context).primaryColor,
                spawnOpacity: 0.0,
                opacityChangeRate: 0.25,
                minOpacity: 0.1,
                maxOpacity: 1,
                particleCount: 70,
                spawnMaxRadius: 3.0,
                spawnMinRadius: 1.0,
                spawnMaxSpeed: 100.0,
                spawnMinSpeed: 30,
              ),
            ),
            vsync: this,
            child: BlocListener(
              bloc: _statsOverallBloc,
              listener: (BuildContext context, state) =>
                  _handleState(context, state),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/matches_played.svg',
                                width: 70),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)?.matches_played ??
                                  'Matches played',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              matchesPlayed.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/solved_problems.svg',
                                width: 70),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)?.solved_problems ??
                                  'Solved tasks',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              solvedProblems.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)?.your_rating_title ??
                                'Your Rating',
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/laurel_wreath_left.svg',
                                  width: 40, color: Colors.amber),
                              Text(
                                rating.toString(),
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              SvgPicture.asset('assets/laurel_wreath_right.svg',
                                  width: 40, color: Colors.amber),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/overall_time.svg',
                                width: 70),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)?.overall_time ??
                                  'Overall time',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              timeSpent,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/avg_time.svg', width: 70),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)?.average_time ??
                                  'Average time',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              averageTime.toString() + " s",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
