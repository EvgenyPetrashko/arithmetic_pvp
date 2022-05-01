import 'dart:developer';
import 'package:arithmetic_pvp/bloc/states/profile_states.dart';
import 'package:arithmetic_pvp/data/models/user.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/auth.dart';
import 'events/profile_events.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    final Auth _apiAuth = GetIt.instance<Auth>();
    final Storage _storage = GetIt.instance<Storage>();

    on<ProfileEventUserLoad>((event, emit) async {
      emit(ProfileStateLoading());
      User? storedUser = _storage.getUser("user");
      if (storedUser == null){
        User? user = await _apiAuth.getUserInfo();
        log(user.toString());
        if (user != null){
          _storage.setUser("user", user);
          emit(ProfileStateLoaded(user));
        }else{
          emit(ProfileStateError("Please try again later"));
        }
      }else{
        emit(ProfileStateLoaded(storedUser));
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