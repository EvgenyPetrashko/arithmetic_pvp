import '../../data/models/user.dart';

abstract class WaitingRoomState {}

class UsersStateLoading extends WaitingRoomState {}

class UsersStateLoaded extends WaitingRoomState {
  List<Profile> users;

  UsersStateLoaded(this.users);
}

class UsersStateError extends WaitingRoomState {
  String error;

  UsersStateError(this.error);
}
