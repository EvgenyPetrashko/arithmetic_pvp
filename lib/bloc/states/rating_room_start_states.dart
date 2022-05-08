import 'package:arithmetic_pvp/data/models/join_room_response.dart';

abstract class RatingRoomStartState {}

class RatingRoomStartStateInitial extends RatingRoomStartState {}

class RatingRoomStartStateLoading extends RatingRoomStartState {}

class RatingRoomStartStateLoaded extends RatingRoomStartState {
  final JoinRoomResponse joinRoomResponse;

  RatingRoomStartStateLoaded(this.joinRoomResponse);
}

class RatingRoomStartStateError extends RatingRoomStartState {
  final String error;

  RatingRoomStartStateError(this.error);
}
