import 'package:arithmetic_pvp/bloc/events/main_events.dart';
import 'package:arithmetic_pvp/bloc/states/main_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/auth_interceptor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/auth.dart';
import '../data/network_client.dart';
import '../data/storage.dart';
import '../main.dart';

class MainBloc extends Bloc<SplashScreenEvent, MainState> {
  MainBloc() : super(MainStateLoading()) {
    on<SplashScreenEventStartLoading>((event, emit) async {
      await Firebase.initializeApp();

      final _getIt = GetIt.instance;

      Storage _storage = await Storage().init();

      final isDark = _storage.getBool("isDark", true);
      MyApp.themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;

      await GetIt.instance.allReady();

      final _authInterceptor = AuthInterceptor(_storage);
      final _client = NetworkClient(_authInterceptor);
      final storageCookie = _storage.getCookie("cookie");
      final sessionCookie = storageCookie?.sessionToken ?? "";

      _getIt.registerSingleton(_client);
      _getIt.registerSingleton<Auth>(Auth(_client));
      _getIt.registerSingleton<Api>(Api(_client));
      _getIt.registerSingleton(_storage);

      await GetIt.instance.allReady();

      if (sessionCookie != "") {
        emit(MainStateLoaded(true));
      } else {
        emit(MainStateLoaded(false));
      }
    });
  }
}
