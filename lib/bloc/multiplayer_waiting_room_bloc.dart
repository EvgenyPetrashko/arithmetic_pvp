import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:arithmetic_pvp/data/web_socket_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../data/models/join_room_response.dart';
import '../data/storage.dart';
import 'events/waiting_room_events.dart';

class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {
  final JoinGameResponse _joinGameResponse;

  WaitingRoomBloc(this._joinGameResponse) : super(WaitingRoomStateInitial()) {
    final _storage = GetIt.instance<Storage>();

    on<WaitingRoomEventPlayerJoined>((event, emit) {
      emit(WaitingRoomStateUsersUpdate(event.playersWaiting));
    });

    on<WaitingRoomEventStartGame>((event, emit) {
      emit(WaitingRoomStateStartGame());
    });

    on<WaitingRoomEventReject>((event, emit) async {
      emit(WaitingRoomStateError());
    });

    on<WaitingRoomEventTimerUpdate>((event, emit) {
      emit(WaitingRoomStateTimerUpdated(event.timeLeft));
    });

    on<WaitingRoomEventAllPlayersJoined>((event, emit) {
      emit(WaitingRoomStateTimerUpdated(
          ((DateTime.parse(event.room.startTime).millisecondsSinceEpoch /
                      1000) -
                  (DateTime.now().millisecondsSinceEpoch / 1000))
              .round()));
    });

    on<WaitingRoomEventInit>((event, emit) {
      if (GetIt.instance.isRegistered<WebSocketProvider>()) {
        GetIt.instance.unregister<WebSocketProvider>();
      }
      final _webSocketProvider = WebSocketProvider(_joinGameResponse.id, {
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

      add(WaitingRoomEventTimerUpdate(
          ((DateTime.parse(_joinGameResponse.startTime).millisecondsSinceEpoch /
                      1000) -
                  (DateTime.now().millisecondsSinceEpoch / 1000))
              .round()));
      emit(WaitingRoomStateInitial());
    });
  }
}
