import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/multiplayer_game_start_events.dart';
import 'package:arithmetic_pvp/bloc/multiplayer_game_start_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/multiplayer_game_start_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'multiplayer_waiting_room.dart';

class MultiplayerGameStartPage extends StatelessWidget {
  const MultiplayerGameStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultiplayerGameStartBloc _multiplayerGameStartBloc =
        MultiplayerGameStartBloc();

    _handleState(context, state) {
      log(state.toString());
      if (state is MultiplayerGameStartStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      } else if (state is MultiplayerGameStartStateLoaded) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_context) => MultiplayerWaitingRoomPage(
                    joinRoomResponse: state.joinGameResponse)));
      }
    }

    return Center(
      child: BlocConsumer(
        bloc: _multiplayerGameStartBloc,
        listener: (context, state) => _handleState(context, state),
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: (state is MultiplayerGameStartStateLoading),
            child: Center(
              child: OutlinedButton(
                onPressed: (state is! MultiplayerGameStartStateLoading)
                    ? () {
                        _multiplayerGameStartBloc
                            .add(MultiplayerGameStartEvent());
                      }
                    : null,
                child: const Text('Start Rating Game'),
              ),
            ),
          );
        },
      ),
    );
  }
}
