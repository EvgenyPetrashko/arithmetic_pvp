import 'package:animated_background/animated_background.dart';
import 'dart:developer';

import 'package:arithmetic_pvp/bloc/rating_room_game_bloc.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/keyboard.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/events/rating_room_game_events.dart';
import '../../bloc/states/rating_room_game_states.dart';
import '../../data/models/player_progress.dart';

import '../stats/stats_postgame.dart';

class MultiplayerGamePage extends StatefulWidget {
  const MultiplayerGamePage({Key? key}) : super(key: key);

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
            ans = ans + command;
          }
          break;
      }
      if (oldAnswer != ans) {
        _ratingRoomGameBloc.add(RatingRoomGameEventSubmitAnswer(ans));
      }
    });
  }

  List<UserProgress> _constructProgressBars(state) {
    if (state is RatingRoomGameStateUpdateProgressbar) {
      setState(() {
        currentProgresses = state.playerProgresses;
        ans = "";
      });
    }
    List<UserProgress> userProgresses = [];
    for (final progress in currentProgresses) {
      userProgresses.add(UserProgress(
        username: progress.id.toString(),
        value: progress.tasksSolved / 10,
        color: Colors.redAccent,
      ));
    }
    return userProgresses;
  }

  _handleState(context, state) {
    log(state.toString());
    if (state is RatingRoomGameStateShowTask) {
      setState(() {
        expression = state.task.content;
      });
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rating Game'),
          actions: [
            TextButton(
              child: const Text(
                'Finish',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostgameStatsPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: AnimatedBackground(
            behaviour:
                RacingLinesBehaviour(numLines: 5, direction: LineDirection.Ltr),
            vsync: this,
            child: BlocConsumer(
                bloc: _ratingRoomGameBloc,
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 20,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: _constructProgressBars(state),
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
                                  expression,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
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
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
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
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
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
                  );
                },
                listener: (context, state) => _handleState(context, state)),
          ),
        ));
  }
}
