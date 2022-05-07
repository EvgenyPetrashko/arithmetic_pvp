import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/rating_room_game_events.dart';
import 'package:arithmetic_pvp/bloc/states/rating_room_game_state.dart';
import 'package:arithmetic_pvp/data/models/task.dart';
import 'package:arithmetic_pvp/data/web_socket_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


class RatingRoomGameBloc extends Bloc<RatingRoomGameEvent,
    RatingRoomGameState>{
  int taskIndex = 0;
  late final List<Task> tasks;
  late final WebSocketProvider webSocketProvider;
  RatingRoomGameBloc() : super(RatingRoomGameStateInitial()) {
    webSocketProvider =
            GetIt.instance<WebSocketProvider>();

    webSocketProvider.webSocketStream.listen( (event) {
      if (event is RatingRoomGameEvent){
        add(event);
      }
    });

    on<RatingRoomGameEventTasksReceived>((event, emit) {
      tasks = event.tasks;
      emit(RatingRoomGameStateShowTask(tasks[taskIndex], taskIndex));
    });

    on<RatingRoomGameEventTaskReport>((event, emit) {
      if (event.taskReport.id != tasks[taskIndex].id){
        log('Report to wrong task received');
        emit(RatingRoomGameStateShowTask(tasks[taskIndex], taskIndex));
      }
      else {
        if (event.taskReport.isCorrect) {
          taskIndex += 1;
        }
        emit(RatingRoomGameStateShowTask(tasks[taskIndex], taskIndex));
      }
    });

    on<RatingRoomGameEventUpdateProgressbar>((event, emit) {
      emit(RatingRoomGameStateUpdateProgressbar(event.playerProgresses));
    });

    on<RatingRoomGameGetTasks>((event, emit) {
      webSocketProvider.getTasks();
    });

    on<RatingRoomGameEventSubmitAnswer>((event, emit) {
      webSocketProvider.submitAnswer(event.answer);
    });
  }
}