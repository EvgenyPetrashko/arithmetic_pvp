import 'dart:async';

import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:arithmetic_pvp/data/web_socket_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../data/models/join_room_response.dart';
import '../data/storage.dart';
import 'events/waiting_room_events.dart';

class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {
  final JoinGameResponse _joinRoomResponse;

  WaitingRoomBloc(this._joinRoomResponse)
      : super(WaitingRoomStateInitial()) {
    final Storage _storage = GetIt.instance<Storage>();

    if (GetIt.instance.isRegistered<WebSocketProvider>()){
      GetIt.instance.unregister<WebSocketProvider>();
    }
    final _webSocketProvider = WebSocketProvider(_joinRoomResponse.id, {
      "cookie": _storage.getCookie("cookie")?.sessionToken ?? "",
    });
    GetIt.instance.registerSingleton<WebSocketProvider>(_webSocketProvider);

    _webSocketProvider.webSocketStream.listen((event) {
      if (event is WaitingRoomEvent) {
        add(event);
      }
    });
    Timer timer = Timer(const Duration(seconds: 5), () {
      add(WaitingRoomEventStartGame());
    });

    on<WaitingRoomEventUsersLoading>((event, emit) {
      emit(WaitingRoomStateUsersUpdate(event.players));
    });

    on<WaitingRoomEventStartGame>((event, emit) {
      timer.cancel();
    });

    on<WaitingRoomEventReject>((event, emit) {});
  }
}
