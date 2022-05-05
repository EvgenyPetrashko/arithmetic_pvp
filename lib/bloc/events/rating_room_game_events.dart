import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';

abstract class RatingRoomGameEvent extends WebSocketEvent {}

class RatingRoomGameEventTasksReceived extends RatingRoomGameEvent {}

class RatingRoomGameEventTaskReport extends RatingRoomGameEvent {}

class RatingRoomGameEventUpdateProgressbar extends RatingRoomGameEvent {}