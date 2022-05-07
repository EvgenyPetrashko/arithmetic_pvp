import 'package:arithmetic_pvp/data/models/player_progress.dart';
import 'package:arithmetic_pvp/data/models/task.dart';

abstract class RatingRoomGameState {}

class RatingRoomGameStateInitial extends RatingRoomGameState {}

class RatingRoomGameStateShowTask extends RatingRoomGameState {
  final Task task;
  final int taskIndex;
  RatingRoomGameStateShowTask(this.task, this.taskIndex);
}

class RatingRoomGameStateUpdateProgressbar extends RatingRoomGameState {
  final List<PlayerProgress> playerProgresses;
  RatingRoomGameStateUpdateProgressbar(this.playerProgresses);
}