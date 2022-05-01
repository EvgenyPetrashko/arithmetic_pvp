abstract class AuthState { }

class AuthStateInitial extends AuthState { }

class AuthStateLoading extends AuthState { }

class AuthStateLoaded extends AuthState { }

class AuthStateError extends AuthState {
  String error;
  AuthStateError(this.error);
}