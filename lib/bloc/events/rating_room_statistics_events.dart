import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';

abstract class RatingRoomStatisticsEvent extends WebSocketEvent {}

class RatingRoomStatisticsEventReceived extends RatingRoomStatisticsEvent {}