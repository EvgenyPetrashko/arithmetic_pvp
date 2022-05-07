import 'dart:async';
import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/waiting_room_events.dart';
import 'package:arithmetic_pvp/bloc/multiplayer_waiting_room_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'multiplayer_game.dart';

class MultiplayerWaitingRoomPage extends StatefulWidget {
  final JoinGameResponse joinRoomResponse;

  const MultiplayerWaitingRoomPage({Key? key, required this.joinRoomResponse})
      : super(key: key);

  @override
  State<MultiplayerWaitingRoomPage> createState() =>
      _MultiplayerWaitingRoomPageState();
}

class _MultiplayerWaitingRoomPageState
    extends State<MultiplayerWaitingRoomPage> {
  late WaitingRoomBloc _waitingRoomBloc;
  Timer? timer;
  List<Player> players = [];
  int secondsLeft = 59;
  int backPressed = 0;

  @override
  void initState() {
    super.initState();
    timer?.cancel();
    _waitingRoomBloc = WaitingRoomBloc(widget.joinRoomResponse);
    _waitingRoomBloc.add(WaitingRoomEventInit());
  }

  startTimer(seconds) {
    timer?.cancel();
    setState(() {
      secondsLeft = seconds;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsLeft -= 1;
        if (secondsLeft <= 0) {
          timer.cancel();
          _waitingRoomBloc.add(WaitingRoomEventStartGame());
        }
      });
    });
  }

  _handleState(context, state) {
    log(state.toString());
    if (state is WaitingRoomStateUsersUpdate) {
      setState(() {
        players = state.players;
      });
    } else if (state is WaitingRoomStateStartGame) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MultiplayerGamePage(players: players),
        ),
      );
    } else if (state is WaitingRoomStateError) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You can't join this room"),
        ),
      );
    } else if (state is WaitingRoomStateTimerUpdated) {
      startTimer(state.timeLeft);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            // title: const Text('AlertDialog Title'),
            content: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'You will not be able to rejoin. Quit anyway?',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 7),
                        primary: const Color(0xffa85454),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 7),
                        primary: const Color(0xff5da854),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text('Quit'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Waiting Room'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/timer.svg',
                    width: 60,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 60.0,
                    child: Center(
                      child: Text(
                        '00:${secondsLeft < 10 ? "0" + secondsLeft.toString() : secondsLeft}',
                        style: TextStyle(
                            color:
                                (secondsLeft < 10) ? Colors.red : Colors.green,
                            fontSize: 32),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SafeArea(
                child: BlocConsumer(
                  bloc: _waitingRoomBloc,
                  listener: (context, state) => _handleState(context, state),
                  builder: (context, state) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: players.length,
                      itemBuilder: (BuildContext context, int index) =>
                          UserCard(player: players[index]),
                    );
                  },
                ),
              ),
            ),
            // Center(
            //   child: JumpingText(
            //     "...",
            //     style: const TextStyle(fontSize: 60),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
