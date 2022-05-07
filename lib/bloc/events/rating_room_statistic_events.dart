import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats_response.dart';

abstract class RatingRoomStatisticEvent extends WebSocketEvent {}

class RatingRoomStatisticEventGetStats extends RatingRoomStatisticEvent {}

class RatingRoomStatisticEventReceived extends RatingRoomStatisticEvent {
  final RatingRoomStatsResponse stats;
  RatingRoomStatisticEventReceived(this.stats);
}