import 'dart:developer';

import 'package:animated_background/animated_background.dart';
import 'package:arithmetic_pvp/bloc/rating_room_game_bloc.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/keyboard.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/events/rating_room_game_events.dart';
import '../../bloc/states/rating_room_game_states.dart';
import '../../data/models/player.dart';
import '../../data/models/player_progress.dart';
import '../stats/stats_postgame.dart';

class MultiplayerGamePage extends StatefulWidget {
  final List<Player> players;

  const MultiplayerGamePage({Key? key, required this.players})
      : super(key: key);

  @override
  State<MultiplayerGamePage> createState() => _MultiplayerGamePageState();
}

class _MultiplayerGamePageState extends State<MultiplayerGamePage>
    with SingleTickerProviderStateMixin {
  final _ratingRoomGameBloc = RatingRoomGameBloc();
  String expression = "";
  String ans = '';
  List<PlayerProgress> currentProgresses = [];

  void updateAns(String command) {
    setState(() {
      String oldAnswer = ans;
      switch (command) {
        case 'DEL':
          {
            if (ans.isNotEmpty) {
              ans = ans.substring(0, ans.length - 1);
            }
          }
          break;

        case '-':
          {
            if (ans.isEmpty) {
              ans = '-';
            } else {
              if (ans[0] == '-') {
                ans = ans.substring(1);
              } else {
                ans = '-' + ans;
              }
            }
          }
          break;

        default:
          {
            if (ans.length < 3) {
              ans = ans + command;
            }
          }
          break;
      }
      if (oldAnswer != ans) {
        final submittedAns = int.tryParse(ans);
        if (submittedAns != null) {
          _ratingRoomGameBloc
              .add(RatingRoomGameEventSubmitAnswer(submittedAns));
        }
      }
    });
  }

  List<double> _progressByPlayers(progresses) {
    List<double> progressesList = [];
    for (var player in widget.players) {
      for (var progress in progresses) {
        if (progress.id == player.playerId) {
          progressesList
              .add(progress.tasksSolved / _ratingRoomGameBloc.tasks.length);
          break;
        }
      }
    }
    return progressesList;
  }

  List<UserProgress> _constructProgressBars() {
    List<UserProgress> userProgresses = [];
    final progressesList = _progressByPlayers(currentProgresses);
    for (var i = 0; i < widget.players.length; i++) {
      userProgresses.add(UserProgress(
        username: widget.players[i].username,
        value: (progressesList.isNotEmpty) ? progressesList[i] : 0,
        color: Colors.redAccent,
      ));
    }
    return userProgresses;
  }

  _handleState(context, state) {
    log(state.toString());
    if (state is RatingRoomGameStateShowTask) {
      if (expression != state.task.content) {
        setState(() {
          expression = state.task.content;
          ans = "";
        });
      }
    } else if (state is RatingRoomGameStateUpdateProgressbar) {
      setState(() {
        currentProgresses = state.playerProgresses;
      });
    } else if (state is RatingRoomGameStateShowStatistic) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PostgameStatsPage(players: widget.players)));
    }
  }

  @override
  void initState() {
    super.initState();
    log("Request tasks");
    _ratingRoomGameBloc.add(RatingRoomGameGetTasks());
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l?.rating_game_title ?? "Rating Game"),
      ),
      body: SafeArea(
        child: AnimatedBackground(
          behaviour:
              RacingLinesBehaviour(numLines: 5, direction: LineDirection.Ltr),
          vsync: this,
          child: BlocListener(
            child: Column(
              children: [
                Expanded(
                  flex: 20,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: _constructProgressBars(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 35,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 55,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            expression.replaceFirst("*", "×"),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: const Text(
                            '=',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 35,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            ans,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 45,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Keyboard(
                      onTap: updateAns,
                    ),
                  ),
                ),
              ],
            ),
            bloc: _ratingRoomGameBloc,
            listener: (context, state) => _handleState(context, state),
          ),
        ),
      ),
    );
  }
}
