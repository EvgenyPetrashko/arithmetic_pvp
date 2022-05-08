import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats_response.dart';

class RatingRoomStats {
  final int coinReward;
  final int ratingDelta;
  final List<String> leaderboard;

  RatingRoomStats(this.coinReward,
                  this.ratingDelta,
                  this.leaderboard);
}
