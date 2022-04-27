import 'package:arithmetic_pvp/data/auth_response.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/auth.dart';

abstract class AuthState {
  final String? cookie;

  AuthState(this.cookie);
}

class AuthStateInitial extends AuthState {
  AuthStateInitial(String? cookie) : super(cookie);
}

class AuthStateLoading extends AuthState {
  AuthStateLoading(String? cookie) : super(cookie);
}

class AuthStateLoaded extends AuthState {
  AuthStateLoaded(String? cookie) : super(cookie);
}

class AuthStateError extends AuthState {
  AuthStateError(String? cookie, this.error) : super(cookie);
  String error;
}

abstract class AuthUserEvent {
  final String token;

  AuthUserEvent(this.token);
}

class AuthUserEventLoad extends AuthUserEvent {
  AuthUserEventLoad(String token) : super(token);
}

class AuthUserEventCancel extends AuthUserEvent {
  AuthUserEventCancel(String token) : super(token);
}

class AuthUserEventStartLoading extends AuthUserEvent{
  AuthUserEventStartLoading(String token) : super(token);
}

class AuthBloc extends Bloc<AuthUserEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial("")) {
    final Auth _apiAuth = GetIt.instance<Auth>();
    final Storage storage = GetIt.instance<Storage>();

    on<AuthUserEventLoad>((event, emit) async {
      AuthResponse authResponse = await _apiAuth.socialLogin(event.token);
      if (!authResponse.error || authResponse.sessionToken == null) {
        _apiAuth.client.api.options.headers["cookie"] =
            authResponse.sessionToken;
        _apiAuth.client.api.options.headers["cookie"] = "";
        storage.setString("cookie", authResponse.sessionToken);
        emit(AuthStateLoaded(authResponse.sessionToken));
      } else {
        AuthStateError(null, "Error during login. Please Try again");
      }
    });

    on<AuthUserEventStartLoading>((event, emit) {
      emit(AuthStateLoading(null));
    });

    on<AuthUserEventCancel>((event, emit) {
      emit(AuthStateInitial(""));
    });
  }
}
