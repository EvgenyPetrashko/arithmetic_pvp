import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats.dart';

abstract class RatingRoomStatisticsEvent extends WebSocketEvent {}

class RatingRoomStatisticsEventReceived extends RatingRoomStatisticsEvent {
  final RatingRoomStats stats;
  RatingRoomStatisticsEventReceived(this.stats);
}