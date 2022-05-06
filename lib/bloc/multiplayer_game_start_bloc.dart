
import 'package:arithmetic_pvp/bloc/events/multiplayer_game_start_events.dart';
import 'package:arithmetic_pvp/bloc/states/multiplayer_game_start_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MultiplayerGameStartBloc extends Bloc<MultiplayerGameStartEvent, MultiplayerGameStartState>{
  MultiplayerGameStartBloc() : super(MultiplayerGameStartStateInitial()){
    final _api = GetIt.instance<Api>();

    on<MultiplayerGameStartEvent>((event, emit) async {
      emit(MultiplayerGameStartStateLoading());
      JoinGameResponse? _joinGameResponse = await _api.joinGame();
      if (_joinGameResponse != null){
        emit(MultiplayerGameStartStateLoaded(_joinGameResponse));
      }else{
        emit(MultiplayerGameStartStateError("Please try again later"));
      }
    });
  }

}