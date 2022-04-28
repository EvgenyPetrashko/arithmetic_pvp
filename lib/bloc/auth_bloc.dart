import 'package:arithmetic_pvp/bloc/states/auth_states.dart';
import 'package:arithmetic_pvp/data/models/auth_response.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/auth.dart';
import 'events/auth_events.dart';

class AuthBloc extends Bloc<AuthUserEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
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
        emit(AuthStateError("Error during login. Please Try again"));
      }
    });

    on<AuthUserEventStartLoading>((event, emit) {
      emit(AuthStateLoading());
    });

    on<AuthUserEventCancel>((event, emit) {
      emit(AuthStateInitial());
    });
  }
}
