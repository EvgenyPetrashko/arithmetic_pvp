class AuthResponse {
  String? sessionToken;
  bool error = false;

  AuthResponse(this.sessionToken, [this.error = false]);
}
