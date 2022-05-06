import 'dart:async';
import 'dart:developer';

import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:arithmetic_pvp/data/web_socket_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../data/models/join_room_response.dart';
import '../data/storage.dart';
import 'events/waiting_room_events.dart';

class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {
  final JoinGameResponse _joinRoomResponse;

  WaitingRoomBloc(this._joinRoomResponse) : super(WaitingRoomStateInitial()) {
    final Storage _storage = GetIt.instance<Storage>();
    int timeLeft =
        ((DateTime.parse(_joinRoomResponse.startTime).millisecondsSinceEpoch /
                    1000) -
                (DateTime.now().millisecondsSinceEpoch / 1000))
            .round();

    if (GetIt.instance.isRegistered<WebSocketProvider>()) {
      GetIt.instance.unregister<WebSocketProvider>();
    }
    final _webSocketProvider = WebSocketProvider(_joinRoomResponse.id, {
      "cookie": _storage.getCookie("cookie")?.sessionToken ?? "",
    });
    GetIt.instance.registerSingleton<WebSocketProvider>(_webSocketProvider);

    _webSocketProvider.webSocketStream.handleError((error) {
      add(WaitingRoomEventReject());
    }).listen((event) {
      if (event is WaitingRoomEvent) {
        add(event);
      }
    });

    Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;
      if (timeLeft == 0) {
        timer.cancel();
        add(WaitingRoomEventStartGame());
      }
      add(WaitingRoomEventTimerUpdate(timeLeft));
    });

    on<WaitingRoomEventPlayerJoined>((event, emit) {
      emit(WaitingRoomStateUsersUpdate(event.playersWaiting));
    });

    on<WaitingRoomEventStartGame>((event, emit) {
      log("Timer canceled");
      timer.cancel();
      emit(WaitingRoomStateStartGame());
    });

    on<WaitingRoomEventReject>((event, emit) {
      timer.cancel();
      emit(WaitingRoomStateError("Room is full"));
    });

    on<WaitingRoomEventTimerUpdate>((event, emit) {
      emit(WaitingRoomStateTimerUpdated(event.timeLeft));
    });

    on<WaitingRoomEventAllPlayersJoined>((event, emit) {
      log("Timer canceled");
      timer.cancel();
      timeLeft = ((DateTime.parse(event.room.startTime).millisecondsSinceEpoch /
                  1000) -
              (DateTime.now().millisecondsSinceEpoch / 1000))
          .round();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeft--;
        if (timeLeft == 0) {
          timer.cancel();
          add(WaitingRoomEventStartGame());
        }
        add(WaitingRoomEventTimerUpdate(timeLeft));
      });
    });
  }
}
