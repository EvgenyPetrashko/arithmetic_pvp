class RatingRoomStatsResponse {
  final int rating;
  final int gold;
  final List<int> leaderboard;

  RatingRoomStatsResponse(
  {
    required this.rating,
    required this.gold,
    required this.leaderboard
  });

  factory RatingRoomStatsResponse.fromJson(Map<String, dynamic> json) =>
      RatingRoomStatsResponse(
          rating: json["rating"] as int,
          gold: json["gold"] as int,
          leaderboard: json["leaderboard"]
              .map((player) => player['player_id'])
              .toList()
              .cast<int>()
  );
}