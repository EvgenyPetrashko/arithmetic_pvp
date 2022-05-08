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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'rating_game.dart';

class MultiplayerWaitingRoomPage extends StatefulWidget {
  final JoinRoomResponse joinRoomResponse;

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
        SnackBar(
          content: Text(AppLocalizations.of(context)?.cant_join_room_msg ??
              "You can't join this room"),
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
                Radius.circular(10),
              ),
            ),
            // title: const Text('AlertDialog Title'),
            content: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                AppLocalizations.of(context)?.waiting_room_dialog_quit ??
                    "You will not be able to rejoin. Quit anyway?",
                style: const TextStyle(
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
                    child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
                          primary: const Color(0xffa85454),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                            AppLocalizations.of(context)?.cancel ?? "Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
                          primary: const Color(0xff5da854),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child:
                            Text(AppLocalizations.of(context)?.quit ?? "Quit"),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
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
          title: Text(
              AppLocalizations.of(context)?.waiting_room ?? "Waiting Room"),
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
