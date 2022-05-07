import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats.dart';

abstract class RatingRoomStatisticEvent extends WebSocketEvent {}

class RatingRoomStatisticEventReceived extends RatingRoomStatisticEvent {
  final RatingRoomStats stats;
  RatingRoomStatisticEventReceived(this.stats);
}