import 'dart:async';
import 'dart:developer';

import 'package:animated_background/animated_background.dart';
import 'package:arithmetic_pvp/presentation/stats/stats_appbar_postgame.dart';
import 'package:arithmetic_pvp/presentation/utils/rain_particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/events/rating_room_statistic_events.dart';
import '../../bloc/rating_room_statistic_bloc.dart';
import '../../bloc/states/rating_room_statistic_states.dart';
import '../../data/models/player.dart';

class PostgameStatsPage extends StatefulWidget {
  final List<Player> players;

  const PostgameStatsPage({Key? key, required this.players}) : super(key: key);

  @override
  State<PostgameStatsPage> createState() => _PostgameStatsPageState();
}

class _PostgameStatsPageState extends State<PostgameStatsPage>
    with SingleTickerProviderStateMixin {
  late RatingRoomStatisticBloc _ratingRoomStatisticBloc;
  late Future futureAlbum;
  int goldChange = 0;
  int ratingChange = 0;
  String ratingChangeAssetPath = "assets/rating_up.svg";
  List<String> leaderboard = ["-", "-", "-"];

  @override
  void initState() {
    super.initState();
    _ratingRoomStatisticBloc = RatingRoomStatisticBloc(widget.players);
    _ratingRoomStatisticBloc.add(RatingRoomStatisticEventGetStats());
  }

  _handleState(context, state) {
    log(state.toString());
    if (state is RatingRoomStatisticStateReceived) {
      setState(() {
        goldChange = state.stats.coinReward;
        ratingChange = state.stats.ratingDelta;
        leaderboard = state.stats.leaderboard;
        if (ratingChange > 0) {
          ratingChangeAssetPath = "assets/rating_up.svg";
        } else {
          ratingChangeAssetPath = "assets/rating_down.svg";
        }
      });
    } else if (state is RatingRoomStatisticStateUpdateLeaderboard) {
      setState(() {
        leaderboard = state.leaderboard;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatsAppBarPostgame(),
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
          child: BlocListener(
              bloc: _ratingRoomStatisticBloc,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      AppLocalizations.of(context)?.leaderboard ??
                          'The Leaderboard',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          SvgPicture.asset('assets/pedestal.svg',
                              width: MediaQuery.of(context).size.width),
                          Transform.translate(
                            offset: Offset(
                                -(MediaQuery.of(context).size.width) / 3.3,
                                -(MediaQuery.of(context).size.width) / 3.3 +
                                    40),
                            child: SizedBox(
                              width: 150,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  leaderboard[1],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(
                                0.0,
                                -(MediaQuery.of(context).size.width) / 3.3 -
                                    30),
                            child: SizedBox(
                              width: 150,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  leaderboard[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(
                                (MediaQuery.of(context).size.width) / 3.3,
                                -(MediaQuery.of(context).size.width) / 3.3 +
                                    70),
                            child: SizedBox(
                              width: 150,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  leaderboard[2],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                              ),
                            ),
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
                            SvgPicture.asset('assets/coins.svg', width: 70),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Coin reward',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  goldChange.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SvgPicture.asset('assets/currency.svg',
                                    height: 30),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/rating.svg', width: 70),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Rating',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  ratingChange.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SvgPicture.asset(ratingChangeAssetPath,
                                    height: 26),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              listener: (context, state) => _handleState(context, state)),
        ),
      ),
    );
  }
}
