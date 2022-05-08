class Cookie {
  String sessionToken;
  int lastRefreshTime;

  Cookie(this.sessionToken, this.lastRefreshTime);

  factory Cookie.fromJson(Map<String, dynamic> json) => Cookie(
        json["cookie"] as String,
        json['lastRefreshTime'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cookie': sessionToken,
        'lastRefreshTime': lastRefreshTime,
      };
}
