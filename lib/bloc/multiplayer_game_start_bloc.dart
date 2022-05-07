import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/multiplayer_game_start_events.dart';
import 'package:arithmetic_pvp/bloc/states/multiplayer_game_start_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

Future<JoinGameResponse> joinGame(Api api) async {
  List<JoinGameResponse>? openGames = await api.getOpenGames();
  if (openGames == null) {
    return await joinGame(api);
  }
  if (openGames.isEmpty) {
    // create game
    JoinGameResponse? joinGameResponse = await api.createGame();
    if (joinGameResponse != null) {
      log("Game created");
      return joinGameResponse;
    } else {
      return await joinGame(api);
    }
  }
  return openGames[0];
}

class MultiplayerGameStartBloc
    extends Bloc<MultiplayerGameStartEvent, MultiplayerGameStartState> {
  MultiplayerGameStartBloc() : super(MultiplayerGameStartStateInitial()) {
    final _api = GetIt.instance<Api>();

    on<MultiplayerGameStartEvent>((event, emit) async {
      emit(MultiplayerGameStartStateLoading());
      List<JoinGameResponse>? openGames = await _api.getOpenGames();
      if (openGames != null) {
        if (openGames.isEmpty) {
          // create game
          JoinGameResponse? _joinGameResponse = await _api.createGame();
          if (_joinGameResponse != null) {
            log("Game created");
            emit(MultiplayerGameStartStateLoaded(_joinGameResponse));
          } else {
            emit(MultiplayerGameStartStateError("Please try again later"));
          }
        } else {
          // select first game
          log("Join room");
          emit(MultiplayerGameStartStateLoaded(openGames[0]));
        }
      } else {
        emit(MultiplayerGameStartStateError("Please try again later"));
      }
    });
  }
}
