import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/rating_room_start_events.dart';
import 'package:arithmetic_pvp/bloc/states/rating_room_start_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

Future<JoinRoomResponse> joinRoom(Api api) async {
  List<JoinRoomResponse>? openRooms = await api.getOpenRooms();
  if (openRooms == null) {
    return await joinRoom(api);
  }
  if (openRooms.isEmpty) {
    // create game
    JoinRoomResponse? joinRoomResponse = await api.createRoom();
    if (joinRoomResponse != null) {
      log("Room created");
      return joinRoomResponse;
    } else {
      return await joinRoom(api);
    }
  }
  return openRooms[0];
}

class RatingRoomStartBloc
    extends Bloc<RatingRoomStartEvent, RatingRoomStartState> {
  RatingRoomStartBloc() : super(RatingRoomStartStateInitial()) {
    final _api = GetIt.instance<Api>();

    on<RatingRoomStartEvent>((event, emit) async {
      emit(RatingRoomStartStateLoading());
      List<JoinRoomResponse>? openRooms = await _api.getOpenRooms();
      if (openRooms != null) {
        if (openRooms.isEmpty) {
          // create room
          JoinRoomResponse? _joinRoomResponse = await _api.createRoom();
          if (_joinRoomResponse != null) {
            log("Room created");
            emit(RatingRoomStartStateLoaded(_joinRoomResponse));
          } else {
            emit(RatingRoomStartStateError("Please try again later"));
          }
        } else {
          // select first game
          log("Join room");
          emit(RatingRoomStartStateLoaded(openRooms[0]));
        }
      } else {
        emit(RatingRoomStartStateError("Please try again later"));
      }
    });
  }
}
