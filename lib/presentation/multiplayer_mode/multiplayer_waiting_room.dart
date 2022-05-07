import 'dart:async';
import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/waiting_room_events.dart';
import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:arithmetic_pvp/bloc/multiplayer_waiting_room_bloc.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MultiplayerGamePage(),
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
        if (backPressed == 0) {
          setState(() {
            backPressed += 1;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press once again to exit"),
            ),
          );
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Waiting Room'),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: BlocConsumer(
                bloc: _waitingRoomBloc,
                listener: (context, state) => _handleState(context, state),
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (BuildContext context, int index) =>
                        UserCard(player: players[index]),
                  );
                },
              ),
            ),
            Positioned(
              right: 10.0,
              bottom: 10.0,
              child: Card(
                elevation: 3,
                child: SizedBox(
                  width: 80.0,
                  height: 60.0,
                  child: Center(
                    child: Text(
                      '00:${secondsLeft < 10 ? "0" + secondsLeft.toString() : secondsLeft}',
                      style: TextStyle(
                          color: (secondsLeft < 10) ? Colors.red : Colors.green,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: JumpingText(
                "...",
                style: const TextStyle(fontSize: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
}
