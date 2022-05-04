abstract class AuthUserEvent {}

class AuthEventInitial extends AuthUserEvent {}

class AuthEventLoad extends AuthUserEvent {
  final String token;

  AuthEventLoad(this.token);
}

class AuthEventCancel extends AuthUserEvent {}

class AuthEventStartLoading extends AuthUserEvent {}
