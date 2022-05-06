import 'dart:convert';
import 'package:arithmetic_pvp/bloc/events/waiting_room_events.dart';
import 'package:arithmetic_pvp/bloc/events/rating_room_game_events.dart';
import 'package:arithmetic_pvp/bloc/events/rating_room_statistics_events.dart';
import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/data/models/player_progress.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats.dart';
import 'package:arithmetic_pvp/data/models/task_report.dart';

import 'package:web_socket_channel/io.dart';

import 'models/task.dart';

class WebSocketProvider {
  late final IOWebSocketChannel webSocketChannel;

  final _url = "";

  WebSocketProvider(roomId, headers) {
    final String _testUrl = "ws://192.168.31.116:8000/ws/rating_room/$roomId/";
    webSocketChannel =
        IOWebSocketChannel.connect(Uri.parse(_testUrl), headers: headers);
  }

  Stream<WebSocketEvent> get webSocketStream =>
      webSocketChannel.stream.handleError((error) {
        _closeSocket();
        throw Exception();
      }).map((response) => _processServerResponse(response));

  _processServerResponse(response) {
    response = jsonDecode(response);
    if (response.containsKey('action')) {
      switch (response['action']) {
        case 'player_joined':
          {
            final List<Player> playersWaiting = response['players_waiting']
                .map((user) => Player.fromJson(user))
                .toList()
                .cast<Player>();
            return WaitingRoomEventPlayerJoined(playersWaiting);
          }
        case 'all_players_joined':
          {
            final room = JoinGameResponse.fromJson(response['room']);
            return WaitingRoomEventAllPlayersJoined(room);
          }
        case 'task_solved':
          {
            final List<PlayerProgress> playerProgresses = response['progress']
                .map(
                    (playerProgress) => PlayerProgress.fromJson(playerProgress))
                .toList()
                .cast<PlayerProgress>();
            return RatingRoomGameEventUpdateProgressbar(playerProgresses);
          }
      }
    }
    switch (response['reponse_to']) {
      case 'get_tasks':
        {
          final List<Task> tasks = response['tasks']
              .map((task) => Task.fromJson(task))
              .toList()
              .cast<Task>();
          return RatingRoomGameEventTasksReceived(tasks);
        }
      case 'submit':
        {
          response.remove('response_to');
          final taskReport = TaskReport.fromJson(response);
          return RatingRoomGameEventTaskReport(taskReport);
        }
      case 'exit':
        {
          response.remove('response_to');
          final stats = RatingRoomStats.fromJson(response);
          return RatingRoomStatisticsEventReceived(stats);
        }
    }
  }

  getTasks(){
    webSocketChannel.sink.add(
      {
        'action': 'get_tasks'
      }
    );
  }

  submitAnswer(answer){
    webSocketChannel.sink.add(
      {
        'action': 'submit',
        'answer': answer
      }
    );
  }

  getStats(){
    webSocketChannel.sink.add(
      {
        'action': 'get_stats'
      }
    );
  }

  closeSocket() {
    webSocketChannel.sink.close();
  }
}
