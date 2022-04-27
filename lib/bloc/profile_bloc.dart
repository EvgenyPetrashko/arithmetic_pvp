import 'dart:developer';
import 'package:arithmetic_pvp/data/models/user.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/auth.dart';

abstract class ProfileState {
  final User? user;

  ProfileState(this.user);
}

class ProfileStateInitial extends ProfileState {
  ProfileStateInitial(User? user) : super(user);
}

class ProfileStateLoading extends ProfileState {
  ProfileStateLoading(User? user) : super(user);
}

class ProfileStateLoaded extends ProfileState {
  ProfileStateLoaded(User? user) : super(user);
}

class ProfileStateError extends ProfileState {
  ProfileStateError(User? user, this.error) : super(user);
  String error;
}

abstract class ProfileUserEvent {}

class ProfileUserEventLoad extends ProfileUserEvent {}

class ProfileBloc extends Bloc<ProfileUserEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial(null)) {
    final Auth _apiAuth = GetIt.instance<Auth>();
    final Storage storage = GetIt.instance<Storage>();

    on<ProfileUserEventLoad>((event, emit) async {
      emit(ProfileStateLoading(null));
      User? storedUser = storage.getUser("user");
      if (storedUser == null){
        _apiAuth.client.api.options.headers["cookie"] = storage.getString("cookie", "");
        User? user = await _apiAuth.getUserInfo();
        log(user.toString());
        if (user != null){
          storage.setUser("user", user);
          emit(ProfileStateLoaded(user));
        }else{
          emit(ProfileStateError(user, "Please try again later"));
        }
      }else{
        emit(ProfileStateLoaded(storedUser));
      }
    });
  }
}