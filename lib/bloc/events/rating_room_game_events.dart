import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/player_progress.dart';
import 'package:arithmetic_pvp/data/models/task_report.dart';

import '../../data/models/task.dart';

abstract class RatingRoomGameEvent extends WebSocketEvent {}

class RatingRoomGameEventTasksReceived extends RatingRoomGameEvent {
  final List<Task> tasks;
  RatingRoomGameEventTasksReceived(this.tasks);
}

class RatingRoomGameEventTaskReport extends RatingRoomGameEvent {
  final TaskReport taskReport;
  RatingRoomGameEventTaskReport(this.taskReport);
}

class RatingRoomGameEventUpdateProgressbar extends RatingRoomGameEvent {
  final List<PlayerProgress> playerProgresses;
  RatingRoomGameEventUpdateProgressbar(this.playerProgresses);
}

class RatingRoomGameGetTasks extends RatingRoomGameEvent {}

class RatingRoomGameEventSubmitAnswer extends RatingRoomGameEvent {
  final String answer;
  RatingRoomGameEventSubmitAnswer(this.answer);
}