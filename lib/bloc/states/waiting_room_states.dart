import 'package:arithmetic_pvp/data/models/player.dart';

abstract class WaitingRoomState {}

class WaitingRoomStateInitial extends WaitingRoomState {}

class WaitingRoomStateUsersUpdate extends WaitingRoomState {
  List<Player> players;

  WaitingRoomStateUsersUpdate(this.players);
}

class WaitingRoomStateError extends WaitingRoomState {
  String error;

  WaitingRoomStateError(this.error);
}

class WaitingRoomStateStartGame extends WaitingRoomState {}

class WaitingRoomStateStartGameError extends WaitingRoomState {
  String error;

  WaitingRoomStateStartGameError(this.error);
}
