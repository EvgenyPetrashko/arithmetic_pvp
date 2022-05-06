import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/player.dart';

abstract class WaitingRoomEvent extends WebSocketEvent {}

class WaitingRoomEventUsersLoading extends WaitingRoomEvent {
  List<Player> players;

  WaitingRoomEventUsersLoading(this.players);
}

class WaitingRoomEventStartGame extends WaitingRoomEvent {}

class WaitingRoomEventReject extends WaitingRoomEvent {}
