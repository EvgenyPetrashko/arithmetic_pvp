// time spent | solved problems | rating(elo) | matches played | average time
import 'dart:async';
import 'package:animated_background/animated_background.dart';
import 'package:arithmetic_pvp/presentation/utils/rain_particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'stats_appbar_overall.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverallStatsPage extends StatefulWidget {
  const OverallStatsPage({Key? key}) : super(key: key);

  @override
  State<OverallStatsPage> createState() => _OverallStatsPageState();
}

class _OverallStatsPageState extends State<OverallStatsPage>
    with SingleTickerProviderStateMixin {
  late Future futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatsAppBarOverall(),
      body: SafeArea(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          AppLocalizations.of(context)?.matches_played??'Matches played',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '1000',
                          style: TextStyle(
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
                          AppLocalizations.of(context)?.solved_problems??'Solved problems',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '2281337',
                          style: TextStyle(
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
                        AppLocalizations.of(context)?.your_rating_title??'Your Rating',
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
                          const Text(
                            "3829",
                            style: TextStyle(
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
                        SvgPicture.asset('assets/overall_time.svg', width: 70),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)?.overall_time??'Overall time',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '7318 hours',
                          style: TextStyle(
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
                          AppLocalizations.of(context)?.average_time??'Average time',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '3 sec',
                          style: TextStyle(
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
    );
  }
}
