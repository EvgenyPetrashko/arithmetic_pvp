import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:arithmetic_pvp/data/web_socket_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events/waiting_room_events.dart';

class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {
  final WebSocketProvider _webSocketProvider;

  WaitingRoomBloc(this._webSocketProvider) : super(WaitingRoomStateUsersLoading()) {
    _webSocketProvider.webSocketStream.listen((event) {
      if (event is WaitingRoomEvent){
        add(event);
      }
    });

    on<WaitingRoomEventUsersLoading>((event, emit) {

    });

    on<WaitingRoomEventStartGame>((event, emit) {

    });

    on<WaitingRoomEventReject>((event, emit) {

    });

  }
}
