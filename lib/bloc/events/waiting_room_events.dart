import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:arithmetic_pvp/data/models/player.dart';

abstract class WaitingRoomEvent extends WebSocketEvent {}

class WaitingRoomEventPlayerJoined extends WaitingRoomEvent {
  final List<Player> playersWaiting;
  WaitingRoomEventPlayerJoined(this.playersWaiting);
}

class WaitingRoomEventAllPlayersJoined extends WaitingRoomEvent {
  final JoinGameResponse room;
  WaitingRoomEventAllPlayersJoined(this.room);
}

class WaitingRoomEventStartGame extends WaitingRoomEvent {}

class WaitingRoomEventReject extends WaitingRoomEvent {}