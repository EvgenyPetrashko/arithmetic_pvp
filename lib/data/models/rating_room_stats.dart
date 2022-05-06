class RatingRoomStats {
  final int rating;
  final int gold;
  final List<int> leaderboard;

  RatingRoomStats(
  {
    required this.rating,
    required this.gold,
    required this.leaderboard
  });

  factory RatingRoomStats.fromJson(Map<String, dynamic> json) =>
      RatingRoomStats(
          rating: json["rating"] as int,
          gold: json["gold"] as int,
          leaderboard: json["leaderboard"]
              .map((player) => player['player_id'])
              .toList()
              .cast<int>()
  );
}