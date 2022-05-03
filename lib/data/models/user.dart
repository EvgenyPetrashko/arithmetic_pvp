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

  Profile({required this.id, required this.user, required this.gold});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] as int,
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        gold: json['gold'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'user': user.toJson(),
        'gold': gold,
      };
}
