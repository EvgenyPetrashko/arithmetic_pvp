class Player{
  int playerId;
  final String username;
  final String? assetUrl;

  Player({required this.playerId, required this.username, required this.assetUrl});

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    playerId: json["player_id"] as int,
    username: json["username"] as String,
    assetUrl: json["asset_url"] as String?,
  );
}