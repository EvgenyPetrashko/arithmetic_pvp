import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats_response.dart';

class RatingRoomStats {
  final int coinReward;
  final int ratingDelta;
  final List<String> leaderboard;

  RatingRoomStats(
      {required this.coinReward,
      required this.ratingDelta,
      required this.leaderboard});

  factory RatingRoomStats.fromRatingRoomStatsResponseAndPlayers(
      RatingRoomStatsResponse stats, List<Player> players, int gold, int rating) {
    List<String> nicknames = stats.leaderboard
        .map((playerId) => players
            .firstWhere((player) => player.playerId == playerId))
        .map((player) => player.username)
        .toList()
        .cast<String>();
    for(int i = 0; i < 3; i++){
      if (i >= nicknames.length){
        nicknames.add('-');
      }
    }
    if (nicknames.length == 4){
      nicknames.removeLast();
    }

    return RatingRoomStats(
        coinReward: stats.gold - gold,
        ratingDelta: stats.rating - rating,
        leaderboard: nicknames);
  }
}
