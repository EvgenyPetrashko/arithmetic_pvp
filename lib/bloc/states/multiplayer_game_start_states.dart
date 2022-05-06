import 'package:arithmetic_pvp/data/models/join_room_response.dart';

abstract class MultiplayerGameStartState {}

class MultiplayerGameStartStateInitial extends MultiplayerGameStartState {}

class MultiplayerGameStartStateLoading extends MultiplayerGameStartState {}

class MultiplayerGameStartStateLoaded extends MultiplayerGameStartState {
  final JoinGameResponse joinGameResponse;

  MultiplayerGameStartStateLoaded(this.joinGameResponse);
}

class MultiplayerGameStartStateError extends MultiplayerGameStartState {
  final String error;

  MultiplayerGameStartStateError(this.error);
}
