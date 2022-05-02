import 'dart:developer';
import 'package:arithmetic_pvp/bloc/states/profile_states.dart';
import 'package:arithmetic_pvp/data/models/user.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/api.dart';
import '../data/auth.dart';
import 'events/profile_events.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    final Auth _apiAuth = GetIt.instance<Auth>();
    final Storage _storage = GetIt.instance<Storage>();
    final Api _api = GetIt.instance<Api>();

    on<ProfileEventUserLoad>((event, emit) async {
      emit(ProfileStateLoading());
      Profile? storedProfile = _storage.getProfile("user");
      if (storedProfile == null){
        Profile? profile = await _api.getProfileInfo();
        log(profile.toString());
        if (profile != null){
          _storage.setProfile("user", profile);
          emit(ProfileStateLoaded(profile));
        }else{
          emit(ProfileStateError("Please try again later"));
        }
      }else{
        emit(ProfileStateLoaded(storedProfile));
      }
    });

    on<ProfileEventCheckUsername>((event, emit) async {
      emit(ProfileStateUsernameCheckLoading());
      bool? isAvailable = await _apiAuth.checkUsernameIsAvailable(event.newUsername);
      log("${event.newUsername} $isAvailable");
      if (isAvailable != null){
        emit(ProfileStateUsernameCheckLoaded(isAvailable));
      }else{
       emit(ProfileStateUsernameCheckError("Please try again later"));
      }
    });
  }
}