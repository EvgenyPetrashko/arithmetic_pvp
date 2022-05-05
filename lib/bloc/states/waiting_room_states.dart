import '../../data/models/user.dart';

abstract class WaitingRoomState {}

class WaitingRoomStateUsersLoading extends WaitingRoomState {}

class WaitingRoomStateUsersLoaded extends WaitingRoomState {
  List<Profile> users;

  WaitingRoomStateUsersLoaded(this.users);
}

class WaitingRoomStateError extends WaitingRoomState {
  String error;

  WaitingRoomStateError(this.error);
}

class WaitingRoomStateStartGameLoading extends WaitingRoomState {}

class WaitingRoomStateStartGameLoaded extends WaitingRoomState {}

class WaitingRoomStateStartGameError extends WaitingRoomState {
  String error;

  WaitingRoomStateStartGameError(this.error);
}
