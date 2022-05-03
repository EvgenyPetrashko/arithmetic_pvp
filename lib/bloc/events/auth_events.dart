abstract class AuthUserEvent {}

class AuthUserEventLoad extends AuthUserEvent {
  final String token;

  AuthUserEventLoad(this.token);
}

class AuthUserEventCancel extends AuthUserEvent {}

class AuthUserEventStartLoading extends AuthUserEvent {}
