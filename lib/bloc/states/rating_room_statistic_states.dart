import 'package:arithmetic_pvp/data/models/rating_room_stats.dart';

abstract class RatingRoomStatisticState {}

class RatingRoomStatisticStateInitial extends RatingRoomStatisticState {}

class RatingRoomStatisticStateReceived extends RatingRoomStatisticState {
  final RatingRoomStats stats;
  RatingRoomStatisticStateReceived(this.stats);

}