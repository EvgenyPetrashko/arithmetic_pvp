class User {
  String username;
  String email;

  User({required this.username, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': username,
        'email': email,
      };
}

class Profile {
  int id;
  User user;
  int gold;
  String? assetUrl;
  int rating;

  Profile(
      {required this.id,
      required this.user,
      required this.gold,
      required this.assetUrl,
      required this.rating});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] as int,
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        gold: json['gold'] as int,
        assetUrl: json['asset_url'] as String?,
        rating: json['rating'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'user': user.toJson(),
        'gold': gold,
        'asset_url': assetUrl,
        'rating': rating,
      };
}
