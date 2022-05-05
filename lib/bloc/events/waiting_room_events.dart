import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';

abstract class WaitingRoomEvent extends WebSocketEvent {}

class WaitingRoomEventUsersLoading extends WaitingRoomEvent {}

class WaitingRoomEventStartGame extends WaitingRoomEvent {}

class WaitingRoomEventReject extends WaitingRoomEvent {}