import 'dart:developer';

import 'package:arithmetic_pvp/bloc/states/profile_states.dart';
import 'package:arithmetic_pvp/data/models/change_name_response.dart';
import 'package:arithmetic_pvp/data/models/user.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/api.dart';
import '../data/auth.dart';
import '../data/models/balance_response.dart';
import '../main.dart';
import 'events/profile_events.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  bool _usernameValidation(String username){
    return username.length >= 6 && RegExp(r'[а-яА-Яa-zA-Z0-9\s]+').hasMatch(username);
  }

  ProfileBloc() : super(ProfileStateInitial()) {
    final Auth _apiAuth = GetIt.instance<Auth>();
    final Storage _storage = GetIt.instance<Storage>();
    final Api _api = GetIt.instance<Api>();

    on<ProfileEventUserLoad>((event, emit) async {
      emit(ProfileStateLoading());
      Profile? storedProfile = _storage.getProfile("user");
      if (storedProfile == null) {
        Profile? profile = await _api.getProfileInfo();
        log(profile.toString());
        if (profile != null) {
          _storage.setProfile("user", profile);
          emit(ProfileStateLoaded(profile));
        } else {
          emit(ProfileStateError("Please try again later"));
        }
      } else {
        emit(ProfileStateLoaded(storedProfile));
        Profile? profile = await _api.getProfileInfo();
        if (profile != null && profile != storedProfile) {
          _storage.setProfile("user", profile);
          emit(ProfileStateLoaded(profile));
        }
      }
    });

    on<ProfileEventChangeUsername>((event, emit) async {
      emit(ProfileChangeUsernameStateLoading());

      if (_usernameValidation(event.newUsername)) {
        emit(ProfileChangeUsernameStateLoading());
        ChangeNameResponse? changeNameResponse =
        await _apiAuth.changeUsername(event.newUsername);
        if (changeNameResponse.status) {
          Profile? profile = _storage.getProfile("user");
          if (profile != null) {
            profile.user.username = event.newUsername;
            _storage.setProfile("user", profile);
          }
        }
        emit(ProfileChangeUsernameStateLoaded(changeNameResponse));
        add(ProfileEventUserLoad());
      } else {
        emit(ProfileChangeUsernameStateLoaded(ChangeNameResponse(status: false,
            error: 'Username may contain only letters and numbers. And be at least 6 chars')));
      }
    });

    on<ProfileEventBalanceUpdate>((event, emit) async {
      emit(ProfileBalanceStateLoading());
      Balance? balance = await _api.getBalances();
      if (balance != null) {
        Profile? profile = _storage.getProfile("user");
        if (profile != null) {
          profile.gold = balance.gold;
          _storage.setProfile("user", profile);
        }
        emit(ProfileBalanceStateLoaded(balance));
      } else {
        emit(ProfileBalanceStateError());
      }
    });

    on<ProfileEventChangeThemeMode>((event, emit) {
      MyApp.themeNotifier.value = event.isDark ? ThemeMode.dark : ThemeMode.light;
      _storage.setBool("isDark", event.isDark);
    });


  }
}
