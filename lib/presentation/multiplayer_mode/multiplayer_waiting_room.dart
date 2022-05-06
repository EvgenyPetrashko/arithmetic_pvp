import 'dart:developer';

import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:arithmetic_pvp/bloc/multiplayer_waiting_room_bloc.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'multiplayer_game.dart';

class MultiplayerWaitingRoomPage extends StatefulWidget {
  final JoinGameResponse joinRoomResponse;

  const MultiplayerWaitingRoomPage(
      {Key? key, required this.joinRoomResponse})
      : super(key: key);

  @override
  State<MultiplayerWaitingRoomPage> createState() =>
      _MultiplayerWaitingRoomPageState();
}

class _MultiplayerWaitingRoomPageState
    extends State<MultiplayerWaitingRoomPage> {
  late WaitingRoomBloc _waitingRoomBloc;
  List<Player> players = [];

  @override
  void initState() {
    super.initState();
    _waitingRoomBloc = WaitingRoomBloc(widget.joinRoomResponse);
  }

  _handleState(context, state) {
    log(state.toString());
    {
      if (state is WaitingRoomStateUsersUpdate) {
        setState(() {
          players = state.players;
        });
      }
      else if (state is WaitingRoomStateStartGame) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MultiplayerGamePage(),
          ),
        );
      }
      else if (state is WaitingRoomStateError){
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting Room'),
        /*actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MultiplayerGamePage(),
                ),
              );
            },
          ),
        ],*/
      ),
      body: SafeArea(
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
    );
  }
}
