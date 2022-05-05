import 'dart:developer';

import 'package:arithmetic_pvp/bloc/states/auth_states.dart';
import 'package:arithmetic_pvp/data/models/auth_response.dart';
import 'package:arithmetic_pvp/data/models/cookie.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/auth.dart';
import 'events/auth_events.dart';

class AuthBloc extends Bloc<AuthUserEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    final Auth _apiAuth = GetIt.instance<Auth>();
    final Storage _storage = GetIt.instance<Storage>();

    on<AuthEventLoad>((event, emit) async {
      AuthResponse authResponse = await _apiAuth.socialLogin(event.token);
      final sessionToken = authResponse.sessionToken;
      if (!authResponse.error && sessionToken != null) {
        _apiAuth.client.api.options.headers["cookie"] = sessionToken;
        _apiAuth.client.api.options.headers.remove("Authorization");
        _storage.setCookie(
            "cookie",
            Cookie(sessionToken,
                (DateTime.now().millisecondsSinceEpoch / 1000).round()));
        emit(AuthStateLoaded());
      } else {
        emit(AuthStateError("Error during login. Please Try again"));
      }
    });

    on<AuthEventStartLoading>((event, emit) async {
      emit(AuthStateLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credentials);
      } else {
        add(AuthEventCancel());
      }
    });

    on<AuthEventCancel>((event, emit) {
      emit(AuthStateInitial());
    });

    on<AuthEventInitial>((event, emit) async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null) {
          log("User is signed in!");
          String token = await user.getIdToken();
          log("token $token");
          add(AuthEventLoad(token));
        } else {
          add(AuthEventCancel());
        }
      });
    });
  }
}
